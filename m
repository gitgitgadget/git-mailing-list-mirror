From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 03 Sep 2008 12:19:57 +0300
Message-ID: <48BE56BD.6050805@gmail.com>
References: <20080903072011.GA14252@atjola.homenet> <7vprnld5ws.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:21:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoY8-0006lf-18
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYICJUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 05:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYICJUK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:20:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:17389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYICJUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:20:08 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1823054ugf.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2JyW9KSsf8nwjEep+AgZvelE9Jn2DvDSpEsdMKleB2M=;
        b=Ve7YRwL9HCaeUBtU/a0Vbd6qAdmpzEdZQZ0zatylPPJjYndSbbWJ40nzMcSV793NC6
         DzhXTyHaXB4LqvH1d6taeCqQsh2TP4DPcpXcXEtbK7STcX7/EWoBIWNPo9+/guY/1u+p
         PVAf6nZUhNySNqa052MIRW0/YzNqoNxPQ00Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YRuZwoKLM+HRUZ/7QWfJuLPxwWdXkQ4EyFTlm+RbVVId9W1UdxmVBeKYPTuaVZKemR
         Zs6P/FdqQBTboUwoR9A+A9ckLUDJGG83A9XpKthr/VCHQY70kPATf+jjb6KEOFi2t+/j
         hgNG5GCF/ElW+48MtbynRGAq7OZi5nS19uDdk=
Received: by 10.67.24.11 with SMTP id b11mr4965017ugj.35.1220433606144;
        Wed, 03 Sep 2008 02:20:06 -0700 (PDT)
Received: from ?10.10.2.7? ( [212.143.191.180])
        by mx.google.com with ESMTPS id 34sm5219315ugh.10.2008.09.03.02.20.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:20:05 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vprnld5ws.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94773>

Note: codeville tried to implement a merge algorithm that considers the=
=20
history to decide what the user wants to do:=20
http://revctrl.org/PreciseCodevilleMerge. Maybe worth while exploring?

Ittay

Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>
>  =20
>> "git merge" produces a (IMHO) wrong result, when a commit from the
>> branch that is to be merged in was cherry-picked into the current br=
anch
>> and later reverted on the original branch. Basically ignoring the
>> revert.
>>    =20
>
> There are a few issues around 3-way merge.
>
> One thing is, what happened in between the common ancestor and the fi=
nal
> results on histories before you initiate the merges does not matter. =
 When
> doing a 3-way merge, you look only at three endpoints: your final sta=
te,
> their final state and the common ancestor between the two.
>
> Your history looks like this:
>
>             123a456
>                3-----------?
>               /           /
>              /           /
>             0-----1-----2
>          123456       123456
>
> During the development between 0..2, your undecision might have cause=
d the
> contents of the file fluctuate back and forth many number of times, b=
ut in
> the end result, you (the one who went 0..1..2) decided that for your
> development, you do not have to change the contents of that path.  Th=
e
> path might have been a xyzzy.h file, and you once added an extern dec=
l of
> a function because you thought a function in xyzzy.c might be needed =
by
> another file frotz.c, but it turned out that the function can stay pr=
ivate
> and you removed that extern decl from xyzzy.h and ended up in the sam=
e
> state.
>
> But the other person who built the history 0..3 decided that having t=
he
> change is better than not having it.  Perhaps his code does use the
> function from some other place and needs an extern.
>
> You are merging the two histories, which means by definition you trus=
t
> your decision and the other guys decision with equal weight.  And her=
e is
> another thing.
>
> When you compare the path in question at 0 and 2, you see they are
> identical.  And you are interpreting that "I say they MUST STAY THE S=
AME,
> while they say they want to change it some way, that is a conflict".
>
> But in 3-way merge context, you do not interpret the fact that someth=
ing
> is identical between 0..2 as "they MUST STAY THE SAME".  Instead, you=
 read
> it as "My history does not care what happens to that path -- if the o=
ther
> guy wants to change it, I'll happily take it."
>
>     Note.  I am not claiming that the above interpretation will alway=
s
>     match what you would expect.  I am just explaining how the underl=
ying
>     concept of 3-way merge works in general.  If you think about it i=
n a
>     realistic context, such as the "extern in xyzzy.h you did not nee=
d to
>     add but the other guy needed to have", you'll realize that more o=
ften
>     than not, "I do not care and let the other guy decide" interpreta=
tion
>     results in a more useful result.
>
> That essentially boils down to three rules:
>
>  (0) If both of you did not change anything, the final result won't h=
ave
>      any change (obvious);
>
>  (1) If you decided you do not have a need to change a path, but the =
other
>      one saw a need, you take the change;
>
>  (2) If you and the other one both wanted to change a path but in a
>      different way, you need to merge at the contents level.
>
> And you are seeing rule (1) in action.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  =20

--=20
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>


--=20
--
Ittay Dror <ittay.dror@gmail.com>
