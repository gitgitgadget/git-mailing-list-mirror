From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Fri, 18 Apr 2008 10:41:00 +0200
Message-ID: <a537dd660804180141h25b7f8e2yf7283f63d49521e6@mail.gmail.com>
References: <200804161626.44174.brian.foster@innova-card.com>
	 <a537dd660804170753i4dcfd189m45a9581294ce5091@mail.gmail.com>
	 <48076F94.7030206@nrlssc.navy.mil>
	 <200804180943.20933.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Apr 19 06:26:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmmAK-0002G0-74
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 10:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbYDRIlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 04:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbYDRIlE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 04:41:04 -0400
Received: from rv-out-0708.google.com ([209.85.198.240]:36949 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752872AbYDRIlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 04:41:00 -0400
Received: by rv-out-0506.google.com with SMTP id k29so255058rvb.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=PdyuzCkzKuBv+D2byMnZT/O2U2Rk77W6GtCWs5syo6M=;
        b=li3rrNfSORcAih8Hkkv9wvADxFvyo2HNzll/dTkVgsNVM+meYMuSYQe2atitHMpRQXQjWQYRLgoQfSlrqOndbB4Paj+5A60aGOm7M8izN1KDgRbtXjzVz28gdNqJUv93TIKA0KnlR+zfXjVwGapYF0I5SzI82sS72HgTv6R3jXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LuvE4wV6nCtQc3Uf55cfdMz47zVkbYIOt2bdm1zoYLsOcd2wBuVo2ayD/XCDFvIXXubBOYZyum0jvn2KB6HRyIArQbu57cC+xN2vMhhmzuZ837IAsiYB5xaN54JUETANzSDSu1hROyIl8nuwKfJgH2TCii9go+Es+jJTF2y4JwA=
Received: by 10.141.71.8 with SMTP id y8mr1374814rvk.32.1208508060103;
        Fri, 18 Apr 2008 01:41:00 -0700 (PDT)
Received: by 10.141.123.21 with HTTP; Fri, 18 Apr 2008 01:41:00 -0700 (PDT)
In-Reply-To: <200804180943.20933.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7bc078018b488218
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79872>

> Brian Foster wrote:
>  > 	$ git filter-branch --tag-name-filter cat -- --branches
>  > 	Which ref do you want to rewrite?
>  > 	$
>
> That's strange. Are there any branches in this repository?  [ ... ]
> Looks like there is a single branch named 'master'.

Brandon et al.,

 correct.  there is just the `master' branch.  it is extremely
 clean and straightforward:   O---O---O---O-- ... --O---O


> The command within git-filter-branch.sh that is being called is
>
>    git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD --branches
>
> In a trim git repository for example this command returns:
>
>    refs/heads/master
>    refs/heads/next
>
> Referring to two branches 'master' and 'next'. These are the references
> that exist in .git/refs/heads/*.
>
> I'd be interested to see what this command returns in your repo.

 below is a full example session, including, eventually,
 the above command `rev-parse ...' command, and several
 observations.  all the outputs are quite short, so I
 include most in full:

	$ git version
	git version 1.5.3
	$
	$ git clone /pub/scm/linux/kernel/git/linux-2.6-usip.git linux-2.6-usip
	Initialized empty Git repository in
/home/bfoster/usip-linux/linux-2.6-usip/.git/
	165531 blocks
	Checking 21723 files out...
	 100% (21723/21723) done
	$
	$ cd linux-2.6-usip
	$ git fsck --full
	broken link from  commit dd3f3c0636cfd50719c706b030db5473b0270add
	              to  commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
	missing commit fb57c018d15005b60f104e57f198ff34a6035b99
	missing commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
	missing commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
	missing commit dff364d8da15be0b856a174062fb785acb1c363e
	broken link from  commit 8700854c41a40d333e90104971c3abbbcf082e57
	              to  commit b8b78d1c09e7009f97a1d624f4d771d7e5bd8551
	missing commit ce33a5e8c32816f38862bc41560a1d646d0803a6
	missing commit 91483db9b01b547ae9cc45c8c98b217642acb40a
	missing commit b8b78d1c09e7009f97a1d624f4d771d7e5bd8551
	broken link from  commit c87c46fe892211f8aa4fd363ccff4f667a9aaf7d
	              to  commit ce33a5e8c32816f38862bc41560a1d646d0803a6
	broken link from  commit fb5967688f7b464421cff28f266b64ad2a313a9e
	              to  commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
	broken link from  commit e5a60f1636cceac33777bb8098a0b7a4a136a56c
	              to  commit fb57c018d15005b60f104e57f198ff34a6035b99
	broken link from  commit 2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
	              to  commit 91483db9b01b547ae9cc45c8c98b217642acb40a
	broken link from  commit 0ff75b3afff6fb306bef221bf1823ccf5ffc568b
	              to  commit dff364d8da15be0b856a174062fb785acb1c363e
	$
	$ git filter-branch --tag-name-filter cat -- --branches
	Which ref do you want to rewrite?
	$
	$ ls -laR .git-rewrite
	.git-rewrite:
	total 16
	drwxrwxr-x  3 bfoster bfoster 4096 Apr 18 10:11 .
	drwxrwxr-x 21 bfoster bfoster 4096 Apr 18 10:11 ..
	-rw-rw-r--  1 bfoster bfoster 1864 Apr 18 10:11 backup-refs
	-rw-rw-r--  1 bfoster bfoster    0 Apr 18 10:11 heads
	drwxrwxr-x  2 bfoster bfoster 4096 Apr 18 10:11 t

	.git-rewrite/t:
	total 8
	drwxrwxr-x 2 bfoster bfoster 4096 Apr 18 10:11 .
	drwxrwxr-x 3 bfoster bfoster 4096 Apr 18 10:11 ..
	$

 watching the execution of git-filter-branch with `bash -x',
 the key point seems to be that `check-ref-formats' is being
 called with what seems to be a bogus argument:

	+ git check-ref-format 'refs/heads/master
	refs/remotes/origin/master'

 that prints nothing on stdout and exits with status 1.
 hence  .git-rewrite/heads  is empty, which is the proximate
 cause of the "Which ref ..." message.  (more on this below.)

	$ git filter-branch --tag-name-filter cat -- --branches
	.git-rewrite already exists, please remove it
	$
	$ git rev-parse --no-flags --revs-only \
		--symbolic-full-name --default HEAD --branches
	7df30811617517bc4d5ec7c190a435667228320c
	$


> You can compare this output to the output you get using --all and also
> relate that to the directory structure beneath .git/refs/

	$ git branch -a
	* master
	  origin/HEAD
	  origin/master
	$

 that seemingly bogus `check-ref-format' argument comes
 from the pipeline (where ref=master):

	git for-each-ref --format='%(refname)' | grep /"$ref"
 i.e.:
	git for-each-ref --format='%(refname)' | grep /master

 so...
	$ git for-each-ref --format='%(refname)'
	refs/heads/master
	refs/remotes/origin/HEAD
	refs/remotes/origin/master
	refs/tags/linux-2.6.15
	refs/tags/linux-usip-v2.6.15
	[ ... ]
	$

 note two names match the RE `/master', hence the bogus
 argument.  the reason for that seems to be (this is a
 guess!) that `rev-parse' is *not* being run as:

	git rev-parse --no-flags --revs-only \
		--symbolic-full-name --default HEAD --branches

 as I _think_ you are claiming it should be, but as:

	git rev-parse --revs-only --symbolic --branches

 the former outputs a list of SHA1s (see above).
 the later outputs just the name `master':

	$ git rev-parse --revs-only --symbolic --branches
	master
	$

 just for completeness, below is the output with `--all':

	$ git rev-parse --no-flags --revs-only \
		--symbolic-full-name --default HEAD --all
	7df30811617517bc4d5ec7c190a435667228320c
	7df30811617517bc4d5ec7c190a435667228320c
	7df30811617517bc4d5ec7c190a435667228320c
	26a33413c95dfda6c70ca4a83da49cddb7b236b9
	3e1e17e642cd2fface5691ab136d79f709af9a1c
	8b9e620aa7f6231e30ddf70cf38759aea7c98070
	cd220dbc113774b420c634fe1907860387883aa2
	acb1587f596e4bfe4c748be742b6bf1509fc88ed
	938ed01b502fbf659de24c4ad1da2bb60e0a3347
	d52b1d70e5f4c0509b6220070a1e585ac9f6d727
	5893ac94b533aba4a9864b0a4a3c346830ec004f
	bf0dfbc784e2734c61818aa0683b716cf82f13e2
	824a82029f8ebf2f72846490a9cd455ceaf2f5cc
	b07c23ef78c785168b579242f652b5f49749b02b
	0ae7caf477cd6a8b265497f1fb2e4273378dcfb4
	57545107a114f6f6fb0bcc9a0d655d84dc32113c
	db7e2bc1e16ab3c6611de4b84fda529e59cb378e
	df1ae0303a60ee0268012e926240720ac4d01de9
	b7e5fe765a0afd315781fb536ffcbd32a6666421
	1effee36b5784ebe5e3e7e7d34bfaf6f63be3afa
	b9a029d4c06eb18778f8907b359fe1616d1e2019
	250210f21cadd70ea5cf459b6dca990d1faecbea
	dc8843f2fd0954c941aff8b06205cd15c1f0873f
	36ee52578b10eb83d2f30e324117bfb9457e1e0e
	f8e0127a4cd3c1e42665a8e895e0c1a9dee052ce
	$
	$ cat .git/refs/heads/master
	7df30811617517bc4d5ec7c190a435667228320c
	$

 this smells like a bug in this particular version
 (1.5.3) of `git', or perhaps in the installation?
 like the repository, both are inherited, and I do
 not know the history.  ;-(

cheers!
	-blf-

-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
