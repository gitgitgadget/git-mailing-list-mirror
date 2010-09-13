From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] setup_tree_pathspec(): interpret '^' as negative pathspec
Date: Mon, 13 Sep 2010 11:39:10 +1000
Message-ID: <AANLkTikKtu9Xp1kvHwCzMoPRubLb0VFKTzbgCvF6Sfxf@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
	<1283961023-4491-8-git-send-email-pclouds@gmail.com>
	<AANLkTin_m+zjHND5AwFhkrZM-VEkn70qgCTwpB2B+RA+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 03:39:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouy0s-0006ud-Ko
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 03:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab0IMBjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 21:39:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60790 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab0IMBjM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 21:39:12 -0400
Received: by wyf22 with SMTP id 22so5587246wyf.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vIgN8S+gz+V4nKwqSMFzvMjKmPe7gBm9TJIxpO2SASc=;
        b=t/LnO1DY1Y5vNSuVUBUE/d3mz/mOp8TXl5n8W8P2BBqg6lNkwAYt7Rf5upxNFAlHGU
         Rpv3kTxax26M8QfzI+ZVFNIVlEC/IDwClnz0TPfyQ3vbfB1UJRWt2ehwE5xMS4CKqxrQ
         RDQ5erXd/4IF4WLWdduPRj/AHOtVKNRjS2ndw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sy0IVznxLliz9bmy8sX9HDfE7r1PUBV+UO3lCtcx7WJipL76ICrps/AaI7Z9mzN5Fm
         oHcJcbvvSJFsU/2ZqkYP6QJCTQWHt/G3GMy98KcYxaOy8MRR7IubHakg/lWB3OryqW3x
         nqZMD4AzvMPGymCwXO1ZQV03WQhLIhnENL774=
Received: by 10.216.22.70 with SMTP id s48mr2002028wes.27.1284341950680; Sun,
 12 Sep 2010 18:39:10 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Sun, 12 Sep 2010 18:39:10 -0700 (PDT)
In-Reply-To: <AANLkTin_m+zjHND5AwFhkrZM-VEkn70qgCTwpB2B+RA+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156067>

2010/9/12 Elijah Newren <newren@gmail.com>:
> 2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> This patch does preparation work for tree exclusion in
>> tree_entry_interesting(). '^' has similar meaning to '!' in
>> gitexcludes. '!' is not used because bash does not like arguments wi=
th
>> a leading '!'.
>>
>> Eventually, "git diff -- foo ^foo/bar" should show differences in fo=
o,
>> except foo/bar. If "git diff -- ^foo" is given, then it implies
>> everything except foo, which could surprise users that
>> "bar" in "git diff -- bar ^foo" has no effect at all.
>
> I really like the work here. =C2=A0There are just two things that I t=
hink
> are missing:
> =C2=A0* It doesn't handle files with leading carats in their name
> =C2=A0* It handles some nested include/exclude cases (e.g. dir
> ^dir/subdir) but not more complicated ones.

Yeah. I originally needed it to compare trees outside narrow area
(i.e. negating all pathspecs). But I would need a more robust
implementation soon when I implement tree widening.

> Note: In the second test, I used:
> =C2=A0* "^funny" to search for all files EXCEPT "funny"
> =C2=A0* "^^funny" to search for a file named "^funny"
> =C2=A0* "^^^funny" to search for all files EXCEPT "^funny"
> I'm not sure if that's really the syntax we want to adopt, but it
> should be easy to change if we decide on some other syntax.

Another way is always treat the leading ^ as negative pathspec. If you
have file "^foo", specify it with ./^foo. There's still problem with
top level entries this way.
--=20
Duy
