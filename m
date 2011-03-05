From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Sat, 05 Mar 2011 11:51:05 +0000
Message-ID: <4D7223A9.6080105@colin.guthr.ie>
References: <4D70EBC3.3010400@colin.guthr.ie> <7vr5am7p30.fsf@alter.siamese.dyndns.org> <7vei6m7muw.fsf@alter.siamese.dyndns.org> <7v39n27llq.fsf@alter.siamese.dyndns.org> <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com> <7vy64u65ta.fsf@alter.siamese.dyndns.org> <loom.20110304T210337-216@post.gmane.org> <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie> <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Miseler <alexander@miseler.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 12:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvq0y-0000yi-VI
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 12:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab1CELvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 06:51:10 -0500
Received: from brent.tribalogic.net ([78.86.109.144]:47250 "EHLO
	summit.brent.tribalogic.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752715Ab1CELvI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 06:51:08 -0500
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id 7237DD8711;
	Sat,  5 Mar 2011 11:51:07 +0000 (GMT)
X-Virus-Scanned: amavisd-new at brent.tribalogic.net
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id NF2Dxf-Ig+1I; Sat,  5 Mar 2011 11:51:06 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Mageia/3.1.8-1.mga1 (1) Thunderbird/3.1.8
In-Reply-To: <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168490>

'Twas brillig, and Junio C Hamano at 04/03/11 22:42 did gyre and gimble:
> Colin Guthrie <gmane@colin.guthr.ie> writes:
> 
>> 'Twas brillig, and Junio C Hamano at 04/03/11 21:33 did gyre and gimble:
>>> In short, Linus and I both know what you are talking about, and we may
>>> revisit that issue later, but the thing is that it would not be very
>>> pleasant, and not something that can be done in one sitting during a
>>> single discussion thread on the list.
>>
>> As a simple option to avoid that, how about just printing out (by
>> default) the line offsets if hunks don't apply 100% cleanly? This would
>> at least alert you to the fact that some fixups were needed.
>>
>> Just a thought...
> 
> ... and a patch to do so would look like this.  "git apply -v" and (GNU)
> "patch -p1" seems to report exactly the same numbers for the problematic
> patch and the initial state that started this discussion.
> 
>  builtin/apply.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 14951da..4d22d16 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2638,6 +2643,14 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
>  				apply = 0;
>  		}
>  
> +		if (apply_verbosely && applied_pos != pos) {
> +			int offset = applied_pos - pos;
> +			if (offset < 0)
> +				offset = 0 - offset;
> +			fprintf(stderr, "Applied at %d (offset %d line(s)).\n",
> +				applied_pos + 1, offset);
> +		}
> +
>  		/*
>  		 * Warn if it was necessary to reduce the number
>  		 * of context lines.

Personally I wouldn't bother making offset absolute... (equiv of
abs(offset)) as knowing it applied earlier or later could be useful...
the direction is lost here and I don't really see why that's nicer for
the user. But maybe that's just my opinion?

Col

PS Many thanks for working on this :)


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
