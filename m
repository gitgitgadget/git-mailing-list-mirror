From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 13/22] documentation: add documentation of the index-v5
 file format
Date: Thu, 11 Jul 2013 18:47:47 +0700
Message-ID: <CACsJy8BT56_DvQ5Y2newJWn4EZjHZnTquypXpO2qDtN1Qh0zRg@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
 <1373184720-29767-14-git-send-email-t.gummerer@gmail.com> <CACsJy8ALSBPq1+TP_YxJ=ecUwpKRY-i2O=+q8qMjtXbjShg3mA@mail.gmail.com>
 <87mwptcom9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:48:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFME-0001vq-AV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3GKLsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:48:18 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:58411 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab3GKLsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:48:17 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so9934693obb.14
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VFntfUAxjeByfQFJv6J86AW7qXzKxbc+CAhub2BliDo=;
        b=DsLRxLzlhpMidQnLufK4DY54mjZey60nn4lzb49FHhUIU40/FPd1XwcTcn3QfQf26P
         mYldlPdmO4sasbvpiy6gSgj912dGK5/DcbU52hDC91hS/xcOsmtfLiuqvAz2qHABK9sB
         aHKPMmJ17Z4TcyrSLN5k4xPfQi2QKtHNJl/6prbBpdMbKQS7dbNk0EFEkYokDKGV/pLC
         5W7Ifd/oSGI4mfSKgdlLAAgrrxFMg9OEPOVoftpxAbiF2zutceQJIioj0t1mJp3chv2y
         aihXx//wGqcTHJg1s0ANTZTMpeqPcQs6MI6n46eJCnwdC8Z18n1FMRPT4qTXCYPUy11n
         H5LQ==
X-Received: by 10.60.83.116 with SMTP id p20mr31169522oey.83.1373543297473;
 Thu, 11 Jul 2013 04:48:17 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 11 Jul 2013 04:47:47 -0700 (PDT)
In-Reply-To: <87mwptcom9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230094>

On Thu, Jul 11, 2013 at 6:39 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Question about the possibility of updating index file directly. If git
>> updates a few fields of an entry (but not entrycrc yet) and crashes,
>> the entry would become corrupt because its entrycrc does not match the
>> content. What do we do? Do we need to save a copy of the entry
>> somewhere in the index file (maybe in the conflict data section), so
>> that the reader can recover the index? Losing the index because of
>> bugs is big deal in my opinion. pre-v5 never faces this because we
>> keep the original copy til the end.
>>
>> Maybe entrycrc should not cover stat fields and statcrc. It would make
>> refreshing safer. If the above happens during refresh, only statcrc is
>> corrupt and we can just refresh the entry. entrycrc still says the
>> other fields are good (and they are).
>
> The original idea was to change the lock-file for partial writing to
> make it work for this case.  The exact structure of the file still has
> to be defined, but generally it would be done in the following steps:
>
>   1. Write the changed entry to the lock-file
>   2. Change the entry in the index
>   3. If we succeed delete the lock-file (commit the transaction)
>
> If git crashes, and leaves the index corrupted, we can recover the
> information from the lock-file and write the new information to the
> index file and then delete the lock-file.

Ah makes sense. Still concerned about refreshing though. Updated files
are usually few while refreshed files could be a lot more, increasing
the cost at #1.
--
Duy
