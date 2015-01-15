From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Thu, 15 Jan 2015 12:23:00 +1100
Message-ID: <CAGyf7-EL03E8oFcuDzGcmN4bKQhroHw-T4Azm4mb0QX9F40RFw@mail.gmail.com>
References: <20150114115130.GA5677@inner.h.apk.li>
	<20150114124936.GC30383@peff.net>
	<20150114143946.GE13247@inner.h.apk.li>
	<xmqqmw5lb7ho.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Krey <a.krey@gmx.de>, Jeff King <peff@peff.net>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:28:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBZEo-0005xK-Ge
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 02:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbbAOB2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 20:28:38 -0500
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43139 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751193AbbAOB2h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2015 20:28:37 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2015 20:28:37 EST
Received: from mail-oi0-f45.google.com ([209.85.218.45]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVLcXxbwDX5qbBDl3C3HlN+2TBPuLe4EI@postini.com; Wed, 14 Jan 2015 17:28:37 PST
Received: by mail-oi0-f45.google.com with SMTP id x69so10244869oia.4
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 17:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8PwH5hAw9j/FQ90ENX7uU4k+f70ps3OPJXlH+RsX/Rw=;
        b=iiZVIdBnxkJDe3XUw4QQttfMljDxHZZZlm76OISJ3hbAxqwxysb3ASIv6yUBBDo55M
         /7+VeC4Jm9t/RAm0zlbsYryc0h3T3k3zkotG8/+jkiSlvImCoycaXBcE67KkNgKhFm4o
         7VAdMQFpZUj3kCtgW8fa1ZF9yBv1PyiXHgbrwaxJunhjgnR0Bq9SrdQeZiDnD4gAhHow
         Ex2sQKOVtQFmVi1Q0el95lCgrjHlE447fBxtwQNBIrEXZ7+u0TQanxiQRuVPPoCUuSRI
         hBtUpXcesApMX70VfkBDjB6j7BoFbRv/OyKDwWq7pOXoOWZTjwcV0ESb0ckeS8/3lPDv
         AQig==
X-Received: by 10.182.126.197 with SMTP id na5mr4414212obb.2.1421284980336;
        Wed, 14 Jan 2015 17:23:00 -0800 (PST)
X-Gm-Message-State: ALoCoQnz/ddF3wF4swpCj+lwRD/diCqz9xYi2Uwvbnm8kAR5jfUJNK1r0oTFWZ5iaaWQgx4xUM3qw0/t4k2vov4RIjVx9fgaijyZYH11OOOS4i8dJa5e4/wQxQaqBTTNOx9BrPlk7UI+Gix3eoYRgZXeBCrqn6n+SA==
X-Received: by 10.182.126.197 with SMTP id na5mr4414208obb.2.1421284980233;
 Wed, 14 Jan 2015 17:23:00 -0800 (PST)
Received: by 10.182.98.225 with HTTP; Wed, 14 Jan 2015 17:23:00 -0800 (PST)
In-Reply-To: <xmqqmw5lb7ho.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262452>

On Thu, Jan 15, 2015 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Krey <a.krey@gmx.de> writes:
>
>> On Wed, 14 Jan 2015 07:49:36 +0000, Jeff King wrote:
>> ...
>>> You don't need the "-f" here. Just "git repack -ad" should be enough
>>> (and the "-f" probably makes it _way_ slower).
>>
>> Indeed, factor four.
>>
>> However, my expectation is that a repack -ad will remove all the
>> old pack files, as what is in there is either referenced and put
>> into the new pack, or dropped => there should be a single pack file
>> afterwards.
>>
>> This is not the case. :-( (Done only with 1.8.2 due to
>> lack of compilers for this box.)
>
> Guess in the dark: "ls -l .git/objects/pack"
> Do you see any .keep files?

I'm one of the Stash developers and just noticed this thread. If the
repository in question has been forked via Stash there likely _will_
be .keep files. Stash uses alternates for forks, so it's possible, by
deleting those kept packs and pruning objects (which you've already
done I see) that you will corrupt, or have already corrupted, some
number of the forks. (At the moment Stash packs "garbage" into a "dead
pack" which it flags with a .keep, to ensure forks don't lose access
to objects that once existed upstream that they still reference.)

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
