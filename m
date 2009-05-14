From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2 3/7] Fix tests to work with core.autocrlf=true --
	new functions
Date: Thu, 14 May 2009 08:43:03 +0100
Message-ID: <20090514074303.GA8713@hashpling.org>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-3-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Thu May 14 09:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Vbe-0001co-Ke
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761556AbZENHnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761635AbZENHnG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:43:06 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:48557 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761632AbZENHnF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:43:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACdoC0rUnw4R/2dsb2JhbADOLoQCBQ
Received: from pih-relay04.plus.net ([212.159.14.17])
  by relay.ptn-ipout02.plus.net with ESMTP; 14 May 2009 08:43:05 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1M4Vaq-0005Kc-Ja; Thu, 14 May 2009 08:43:05 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n4E7h4dl022760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 08:43:04 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n4E7h31v022758;
	Thu, 14 May 2009 08:43:03 +0100
Content-Disposition: inline
In-Reply-To: <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 893e5c60da17aee9ad75ab62b8da11e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119164>

On Wed, May 13, 2009 at 03:35:44PM -0400, Don Slutz wrote:
>  test_expect_success 'mergetool crlf' '
>      git config core.autocrlf true &&
> -    git checkout -b test2 branch1
> +    rm -f .git/index &&
> +    git reset --hard &&
> +    git checkout -b test2 branch1 &&
>      test_must_fail git merge master >/dev/null 2>&1 &&
>      ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
>      ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
> @@ -62,16 +66,35 @@ test_expect_success 'mergetool crlf' '
>      test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
>      test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
>      git commit -m "branch1 resolved with mergetool - autocrlf" &&
> +    git config core.autocrlf $autocrlf &&
> +    rm -f .git/index &&
> +    git reset --hard
> +'
> +
> +test_expect_success 'mergetool lf' '
>      git config core.autocrlf false &&
> +    rm -f .git/index &&
> +    git reset --hard &&
> +    git checkout -b test3 branch1 &&
> +    test_must_fail git merge master >/dev/null 2>&1 &&
> +    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
> +    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
> +    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> +    test "$(printf x | cat file1 -)" = "$(printf "master updated\nx")" &&
> +    test "$(printf x | cat file2 -)" = "$(printf "master new\nx")" &&
> +    test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\nx")" &&
> +    git commit -m "branch1 resolved with mergetool - autocrlf2" &&
> +    git config core.autocrlf $autocrlf &&
> +    rm -f .git/index &&
>      git reset --hard
>  '

Have I missed some previous recent discussion about this patch series?
I know that you referenced that long Aug 2007 thread about autocrlf,
but is there some more recent discussion about how the test suite
works / should work?

mergetool isn't the prime implementor of autocrlf, but it does have
some checks to make sure that it works with autocrlf. My impression -
probably incorrect - has been that autocrlf is off for the purposes of
building and testing git on all platforms, but that some packages
switch it on by default on install for user convenience on platforms
where this is appropriate.

Your patch seems to be about allowing the entire test suite to run
correctly with the autocrlf in any setting. If this is the case,
shouldn't the correct fix be to remove tests that are testing that
things work with different settings of autocrlf, because these tests
are effectively run by a full test suite run with autocrlf
alternatively set anyway?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
