From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: .gitconfig folder
Date: Wed, 27 May 2015 15:38:12 -0700
Message-ID: <xmqq1ti1k5nv.fsf@gitster.dls.corp.google.com>
References: <5565C6A7.60007@gmx.es>
	<xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
	<20150527221813.GF23259@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 00:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxjxr-0000a0-E1
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbbE0WiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:38:15 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35038 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbbE0WiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:38:14 -0400
Received: by igbyr2 with SMTP id yr2so97898466igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ptz6pkggSGmdS588/KLEpK+PDCKxmsnXnnvWRCm2hZ4=;
        b=Uio8feBxm4vcqyCAQeumww/X7jdDUvWS0S9ImLQCeVqt3YBvAJGhsHypqZie6949lS
         XihTQATAGVPth/EajTzDG1eY3UKvKW54AgwLhOHrYOZIUUMyokQepPQD6dtag9fgVWVo
         jFwqkjJc29ETL7ovAwtVeXzHtvHgGupbGBa6VSYqESKoHtEqtXSCsXWqHltb7JsVJ0cx
         3mX5ytBMa3m2B8nH1F2mmZE8BMnCp9S4utDCjKIU116io+hSsuTkYbDtrjdeSwXpR1GQ
         uo485LevisMAqzmUL2Hm1gOYyB+9vTjacE+7Xzhu3DkxcdJedSd0hSPXtMcb2PJExrHN
         9j2g==
X-Received: by 10.50.62.148 with SMTP id y20mr39844491igr.17.1432766294007;
        Wed, 27 May 2015 15:38:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id ot6sm2826851igb.11.2015.05.27.15.38.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 15:38:13 -0700 (PDT)
In-Reply-To: <20150527221813.GF23259@peff.net> (Jeff King's message of "Wed,
	27 May 2015 18:18:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270115>

Jeff King <peff@peff.net> writes:

>> -			die_errno("Out of memory? mmap failed");
>> +			die_errno("mmap failed");
>
> This is definitely an improvement, but the real failing of that error
> message is that it does not tell us that "~/.gitconfig" is the culprit.
> I don't think we can do much from xmmap, though; it does not have the
> filename. It would be nice if we got EISDIR from open() in the first
> place, but I don't think we can implement that efficiently (if we added
> an "xopen" that checked that, it would have to stat() every file we
> opened).

The patch was meant to be a tongue-in-cheek tangent that is a vast
improvement for cases where we absolutely need to use mmap but does
not help the OP at all ;-)  I do not think there is any need for the
config reader to read the existing file via mmap interface; just
open it, strbuf_read() the whole thing (and complain when it cannot)
and we should be ok.

Or do we write back through the mmaped region or something?
