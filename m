From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [Bug?] "diff -B --color" output doesn't show space errors
Date: Tue, 15 Sep 2009 12:34:56 +0900
Message-ID: <20090915123456.6117@nanako3.lavabit.com>
References: <wavexx-2ECE7F.13171313092009@ger.gmane.org>
	<7viqfmsoej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Yuri D'Elia" <wavexx@users.sf.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 05:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnOpA-00083e-2O
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 05:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963AbZIODfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 23:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbZIODfF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 23:35:05 -0400
Received: from karen.lavabit.com ([72.249.41.33]:45195 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379AbZIODfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 23:35:04 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 6108211B866;
	Mon, 14 Sep 2009 22:35:07 -0500 (CDT)
Received: from 9427.lavabit.com (delhi-202.54.61-99.vsnl.net.in [202.54.61.99])
	by lavabit.com with ESMTP id BF93IE0FG4YX; Mon, 14 Sep 2009 22:35:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=wPveRhaN2VdetKzi0AMOadXJtTJblkZ+m38BkfPzXn7QQXGYuVuQHMI3tl8/GC2YBDeanJmRCgS8zzE5EWVyYnJRSnfo+s3ZsbttmHl2HMPPTmgG9pfHLyHWCAxq6FzpZjbw/VoALmDd0ehcOr7i0iEAqmsB4bMgDnU/1lTgniw=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7viqfmsoej.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128506>

Quoting Junio C Hamano <gitster@pobox.com>

> By default, if the pathname that was present in the old version still
> appears in the new version, that path is not considered as a candiate
> for rename detection.  Only "X used to be there but is gone" and "Y did
> not exist but appeared" are paired up and checked if they are similar.
>
> Give the command -B option, too, to break the filepair that does not
> disappear.

I wanted to try this -B option, and wrote a little test program.

While it shows correctly that the file was rewritten, it doesn't
point out various whitespace mistakes in the file anymore.

Is this a bug, or should I give some other options as well?

-- >8 -- cut here -- 8< --
git init

cat >file <<"EOF"
This is an article that will be
completely rewritten in a
later commit.
EOF

git add file

sed -e "s/T/\t/g" -e "s/_/ /g" >file <<"EOF"
An article was written but it was_
later rewritten to be_
a completely different text.
_____
An article was written but it was_
later rewritten to be_
a completely different text.

An article was written but it was_
later rewritten to be_
a completely different text.

Worse yet, the replacement text_
introduces a lot of
_Twhite space errors_
such as SP before HT and trailing
whitespaces, when the file was modified by the 
later commit.

Also there are trailing empty lines at the end of the file.



EOF

git diff --color
git diff --color -B
# end of test program

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
