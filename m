From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v4 2/4] t7102 (reset): refactoring: don't hardcode SHA-1
 in expected outputs
Date: Fri, 25 Jan 2013 13:08:59 +0400
Message-ID: <20130125130859.02acc8f8@ashu.dyn1.rarus.ru>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<63637506fa940f6dd5fc050c7fccfa5ef41993dd.1359018188.git.Alex.Crezoff@gmail.com>
	<7vy5fi9vcz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:09:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfHu-00028S-7K
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3AYJJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:09:08 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47336 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab3AYJJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:09:04 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so313670lbb.8
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=HYLu6wHgkCYhUB9IktIYGzOfB/DjzYFk3cDYOOCg5Tw=;
        b=xkeXpoh14Q6/KHLJAiLmlbOTZvqOROGlr9WI//VddqVHGtSTi4LYiILTypwCOalTcz
         pYfHJ697KhLYw1oNfjPcaIE96u9Fi85Qk/pHowGjLXXRBtQBQ/nBm0/GzAItpTzBTGah
         Ocjja8kiDh3wPgcJNSH72zbFodGXlKMgOBUpL8sGqbP0EogvDIOiG0jWHw7zXVi90U3l
         VMV8QF1qYynE6UTy9E2Hyl80hdwIyDnS3CQiOJFsV8qlQY11gasjf1nWfQiANfzfRxKb
         ZR7r16Y7W/TRhBV8r5bdeFDc5T8q7KlHMKZd+ceMgxuIUN3N5LVHvOZzq4Z+MTP2Nxk/
         qdrw==
X-Received: by 10.112.8.231 with SMTP id u7mr1875343lba.45.1359104942234;
        Fri, 25 Jan 2013 01:09:02 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id s9sm227959lbc.12.2013.01.25.01.09.01
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:09:01 -0800 (PST)
In-Reply-To: <7vy5fi9vcz.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214522>

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > The expected SHA-1 digests are always available in variables.  Use
> > them instead of hardcoding.
> >
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > ---
> 
> Looks good (" refactoring:" in the title may not want to be there,
> though).
oops, it's remained from "working version" after rebasing

> 
> Thanks.
> 
> >  t/t7102-reset.sh | 41 +++++++++++++++++++++--------------------
> >  1 file changed, 21 insertions(+), 20 deletions(-)
> >
> > diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> > index b096dc8..cf492f4 100755
> > --- a/t/t7102-reset.sh
> > +++ b/t/t7102-reset.sh
> > @@ -28,7 +28,8 @@ test_expect_success 'creating initial files and
> > commits' ' 
> >  	echo "1st line 2nd file" >secondfile &&
> >  	echo "2nd line 2nd file" >>secondfile &&
> > -	git commit -a -m "modify 2nd file"
> > +	git commit -a -m "modify 2nd file" &&
> > +	head5=$(git rev-parse --verify HEAD)
> >  '
> >  # git log --pretty=oneline # to see those SHA1 involved
> >  
> > @@ -56,7 +57,7 @@ test_expect_success 'giving a non existing
> > revision should fail' ' test_must_fail git reset --mixed aaaaaa &&
> >  	test_must_fail git reset --soft aaaaaa &&
> >  	test_must_fail git reset --hard aaaaaa &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  test_expect_success 'reset --soft with unmerged index should fail'
> > ' @@ -74,7 +75,7 @@ test_expect_success \
> >  	test_must_fail git reset --hard -- first &&
> >  	test_must_fail git reset --soft HEAD^ -- first &&
> >  	test_must_fail git reset --hard HEAD^ -- first &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  test_expect_success 'giving unrecognized options should fail' '
> > @@ -86,7 +87,7 @@ test_expect_success 'giving unrecognized options
> > should fail' ' test_must_fail git reset --soft -o &&
> >  	test_must_fail git reset --hard --other &&
> >  	test_must_fail git reset --hard -o &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  test_expect_success \
> > @@ -110,7 +111,7 @@ test_expect_success \
> >  
> >  	git checkout master &&
> >  	git branch -D branch1 branch2 &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  test_expect_success \
> > @@ -133,27 +134,27 @@ test_expect_success \
> >  
> >  	git checkout master &&
> >  	git branch -D branch3 branch4 &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  test_expect_success \
> >  	'resetting to HEAD with no changes should succeed and do
> > nothing' ' git reset --hard &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset --hard HEAD &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset --soft &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset --soft HEAD &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset --mixed &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset --mixed HEAD &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +		check_changes $head5 &&
> >  	git reset HEAD &&
> > -		check_changes
> > 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +		check_changes $head5
> >  '
> >  
> >  >.diff_expect
> > @@ -176,7 +177,7 @@ test_expect_success '--soft reset only should
> > show changes in diff --cached' ' git reset --soft HEAD^ &&
> >  	check_changes d1a4bc3abce4829628ae2dcb0d60ef3d1a78b1c4 &&
> >  	test "$(git rev-parse ORIG_HEAD)" = \
> > -			3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +			$head5
> >  '
> >  
> >  >.diff_expect
> > @@ -193,7 +194,7 @@ test_expect_success \
> >  	git commit -a -C ORIG_HEAD &&
> >  	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
> >  	test "$(git rev-parse ORIG_HEAD)" = \
> > -			3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +			$head5
> >  '
> >  
> >  >.diff_expect
> > @@ -303,7 +304,7 @@ test_expect_success 'redoing the last two
> > commits should succeed' ' echo "1st line 2nd file" >secondfile &&
> >  	echo "2nd line 2nd file" >>secondfile &&
> >  	git commit -a -m "modify 2nd file" &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  >.diff_expect
> > @@ -341,15 +342,15 @@ EOF
> >  test_expect_success \
> >  	'--hard reset to ORIG_HEAD should clear a fast-forward
> > merge' ' git reset --hard HEAD^ &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +	check_changes $head5 &&
> >  
> >  	git pull . branch1 &&
> >  	git reset --hard ORIG_HEAD &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> > +	check_changes $head5 &&
> >  
> >  	git checkout master &&
> >  	git branch -D branch1 branch2 &&
> > -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> > +	check_changes $head5
> >  '
> >  
> >  cat > expect << EOF
