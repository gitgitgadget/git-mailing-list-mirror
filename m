From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to 'ref-filter'
Date: Mon, 25 May 2015 12:39:47 -0700
Message-ID: <xmqq617gbg58.fsf@gitster.dls.corp.google.com>
References: <556317F8.2070609@gmail.com>
	<1432557943-25337-1-git-send-email-karthik.188@gmail.com>
	<xmqqegm4bmtg.fsf@gitster.dls.corp.google.com>
	<55636301.7060803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	matthieu.moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 21:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwyE8-0000bA-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 21:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbEYTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 15:39:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:32925 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbEYTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 15:39:49 -0400
Received: by iebgx4 with SMTP id gx4so77847187ieb.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c9/bvc2sKHVJ8H1N01GOrx2EQQJIyCrIMavwpZHXDpg=;
        b=UCjrVH9kgOPsOkDWgPjJhNOZaY4eIyWcNGq4r6x3wBR+l2/LidmA1OrJzKIQI14VWI
         mGczIXt34m62V2QHNouLUkx/exbLC0XrMa7nZ9o9uQhVmrv1RI6cUv0TjoXm39xoVD+l
         39XkjaVbcFbsB2f1kaBCVENs2mgPYFbFIazqVEDajRy9siXCR29ICVl/203NVOLj9OwZ
         x1MJo3yjxUX9NuqC0oEqQzPlcme0oHd8o8ojNXcj1k75bs3Dgxi8Ghsgj23uuxpvCZc/
         Ddm8Ll6K0/ItVBB5rJ3zcBufSYQl9p9Fth453KDDAKTY3gjx/0dvhRscv2s9WIwIJ2f9
         sTBw==
X-Received: by 10.107.3.79 with SMTP id 76mr29442958iod.60.1432582788553;
        Mon, 25 May 2015 12:39:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id m9sm6709832igv.4.2015.05.25.12.39.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 12:39:47 -0700 (PDT)
In-Reply-To: <55636301.7060803@gmail.com> (Karthik Nayak's message of "Mon, 25
	May 2015 23:29:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269908>

Karthik Nayak <karthik.188@gmail.com> writes:

>> I do not see much point in renaming between these two.  The latter
>> makes it sound as if this is only for "filtering" and from that
>> angle of view is probably a worse name.  If you do not think of a
>> better one, and if you are going to name the array that contains
>> this thing "ref_list", calling "ref_list_item" would be following
>> suit to what string-list did.
>>
>
> Well I just wanted to keep it related to 'ref-filter', I think
> 'ref_list_item'
> sounds better after seeing your point of view.

Also I think Matthieu already commented that "filter" was out of
place for that struct.  I still think your ref_list is better called
ref_array, but that is a minor point.  Use of "foo_list" in our
codebase is predominantly (because we use "commit_list" very often
in the core part of the system) for a linear linked list where you
do not have a random access to the items.  string-list is misnomer,
I would think.

> I didn't know about the "we are trying to move away from calling the
> name of objects as "sha1[]"". Will leave it as objectname then.

I think you now know after seeing that 56-patch series ;-)

>> You didn't explain why you reordered the fields, either.  Were you
>> planning to make the name[] field to flex-array to reduce need for
>> one level of redirection or something?
>>
>
> Yes! exactly why the re-order, was going to rebase it and squash it
> in, if the code seemed to be up and running.

If that is the case, I would suggest making that "turn it flex array"
a separate step.
