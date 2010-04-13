From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/9] t7006: test pager configuration for several git commands
Date: Tue, 13 Apr 2010 08:34:38 +0200
Message-ID: <4BC4107E.20101@viscovery.net>
References: <20100413021153.GA3978@progeny.tock> <20100413021734.GB4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 08:34:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Zi2-0004bM-4b
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 08:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0DMGeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 02:34:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41630 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751260Ab0DMGeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 02:34:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O1Zhn-0007bw-CM; Tue, 13 Apr 2010 08:34:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 154641660F;
	Tue, 13 Apr 2010 08:34:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100413021734.GB4118@progeny.tock>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144792>

Am 4/13/2010 4:17, schrieb Jonathan Nieder:
> +test_pager_choice() {
> +...
> +	test_expect_success SIMPLEPAGER "$cmd - default pager is used by default" "
> +		cat > $less <<-\EOF &&
> +		#!$SHELL_PATH

This shell script is simple enough that you can use '#!/bin/sh' and avoid
$ expansion where one must ask whether it needs quoting or not.

> +		wc > default_pager_used
> +		EOF
> +...
> +	"
> +...
> +	test_expect_success TTY "$cmd - PAGER overrides default pager" "
> +...
> +	$test_expect_expected TTY "$cmd - core.pager in subdir" "
> +...
> +	test_expect_success TTY "$cmd - GIT_PAGER overrides core.pager" "
> +...
>  
> +test_pager_choice 'git log'
> +test_pager_choice 'git -p log'
> +test_pager_choice test_must_fail 'git -p'
> +test_pager_choice test_must_fail 'git -p nonsense'

The intents of the test cases would be much easier to follow and to review
if this were written as, for example:

test_default_pager        'git log'
test_PAGER_overrides      'git log'
test_core_pager_overrides 'git log'
test_core_pager_subdir    'git log'
test_GIT_PAGER_overrides  'git log'
test_default_pager        'git -p log'
test_PAGER_overrides      'git -p log'
test_core_pager_overrides 'git -p log'
test_core_pager_subdir    'git -p log' fails
test_GIT_PAGER_overrides  'git -p log'
test_default_pager        'test_must_fail git -p'
test_PAGER_overrides      'test_must_fail git -p'
test_core_pager_overrides 'test_must_fail git -p'
test_core_pager_subdir    'test_must_fail git -p' fails
test_GIT_PAGER_overrides  'test_must_fail git -p'
test_default_pager        'test_must_fail git -p nonsense'
test_PAGER_overrides      'test_must_fail git -p nonsense'
test_core_pager_overrides 'test_must_fail git -p nonsense'
test_core_pager_subdir    'test_must_fail git -p nonsense' fails
test_GIT_PAGER_overrides  'test_must_fail git -p nonsense'

the point being that it is less factorized (not the exact syntax).

-- Hannes
