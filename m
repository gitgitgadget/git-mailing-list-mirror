From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using empty
 peg rev
Date: Tue, 09 Oct 2012 11:47:44 +0200
Message-ID: <5073F2C0.6000504@drmicha.warpmail.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com> <1343468872-72133-2-git-send-email-schwern@pobox.com> <20120728141652.GA1603@burratino> <50143E34.8090802@pobox.com> <20121009084145.GA19784@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:48:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLWQ8-0002jv-A1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 11:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab2JIJsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 05:48:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34188 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893Ab2JIJsA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 05:48:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B955920668;
	Tue,  9 Oct 2012 05:47:59 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 09 Oct 2012 05:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=N8ITqCcIB+FJwcZLzoTobz
	/UI44=; b=NXHZz+ifpeJUC9syF4LbHvmA/bzgmZZ0iWKnVUfrWtl12D5xoVb1kY
	Jx1oXAwQ4y+5LkM7rc86Wzl+lAqIkrDSPTxINEn/feU3BBC/+UlnW+bI685bDXj4
	wIGplJrWchYUk/P2t7kZsr7+vlyphaKXxrmZiI2/WtCVdaEF992Z0=
X-Sasl-enc: r94oKBfymDLDxOq18j7ecTircmzjLARIH6JWPCYZzKIK 1349776066
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 619034827EC;
	Tue,  9 Oct 2012 05:47:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120911 Thunderbird/15.0.1
In-Reply-To: <20121009084145.GA19784@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207314>

Jonathan Nieder venit, vidit, dixit 09.10.2012 10:41:
> This test script uses "svn cp" to create a branch with an @-sign in
> its name:
> 
> 	svn cp "pr ject/trunk" "pr ject/branches/not-a@{0}reflog"
> 
> That sets up for later tests that fetch the branch and check that git
> svn mangles the refname appropriately.
> 
> Unfortunately, modern svn versions interpret path arguments with an
> @-sign as an example of path@revision syntax (which pegs a path to a
> particular revision) and truncate the path or error out with message
> "svn: E205000: Syntax error parsing peg revision '{0}reflog'".
> 
> When using subversion 1.6.x, escaping the @ sign as %40 avoids trouble
> (see 08fd28bb, 2010-07-08).  Newer versions are stricter:
> 
> 	$ svn cp "$repo/pr ject/trunk" "$repo/pr ject/branches/not-a%40{reflog}"
> 	svn: E205000: Syntax error parsing peg revision '%7B0%7Dreflog'
> 
> The recommended method for escaping a literal @ sign in a path passed
> to subversion is to add an empty peg revision at the end of the path
> ("branches/not-a@{0}reflog@").  Do that.
> 
> Pre-1.6.12 versions of Subversion probably treat the trailing @ as
> another literal @-sign (svn issue 3651).  Luckily ever since
> v1.8.0-rc0~155^2~7 (t9118: workaround inconsistency between SVN
> versions, 2012-07-28) the test can survive that.
> 
> Tested with Debian Subversion 1.6.12dfsg-6 and 1.7.5-1 and r1395837
> of Subversion trunk (1.8.x).
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Tested with Subversion 1.6.18.

> ---
> Michael G Schwern wrote:
>> On 2012.7.28 7:16 AM, Jonathan Nieder wrote:
>>> Michael G. Schwern wrote:
> 
>>>> -		git rev-parse "refs/remotes/not-a%40{0}reflog"
>>>> +		git rev-parse "refs/remotes/$non_reflog"
>>>
>>> Doesn't this defeat the point of the testcase (checking that git-svn
>>> is able to avoid creating git refs containing @{, following the rules
>>> from git-check-ref-format(1))?
>>
>> Unless I messed up, entirely possible as I'm not a shell programmer, the test
>> is still useful for testing SVN 1.6.  Under SVN 1.6 $non_reflog should be
>> 'not-a%40{0}reflog' as before.
> 
> Here's a patch to make the test useful again for SVN 1.7.  Sensible?
> 
>  t/t9118-git-svn-funky-branch-names.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
> index 193d3cab..15f93b4c 100755
> --- a/t/t9118-git-svn-funky-branch-names.sh
> +++ b/t/t9118-git-svn-funky-branch-names.sh
> @@ -28,7 +28,7 @@ test_expect_success 'setup svnrepo' '
>  	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
>  			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
>  	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
> -			"$svnrepo/pr ject/branches/not-a%40{0}reflog" &&
> +			"$svnrepo/pr ject/branches/not-a@{0}reflog@" &&
>  	start_httpd
>  	'

I haven't checked other svn versions but this approach looks perfectly
sensible. It makes us test branch names which can't even be created
easily with current svn. Does svn really deserve this much attention? ;)

Seriously, our tests prepare us well for an svn remote helper...
