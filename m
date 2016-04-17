From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 2/2] t1500-rev-parse: rewrite each test to run in
 isolation
Date: Sun, 17 Apr 2016 11:42:53 +0200
Message-ID: <20160417114253.Horde.giIo57RkUzhAe6GP-RahIrw@webmail.informatik.kit.edu>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
 <1460823230-45692-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	pclouds@gmail.com, peff@peff.net
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 11:43:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arjEj-000669-RW
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 11:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbcDQJnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 05:43:17 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57532 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487AbcDQJnR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 05:43:17 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1arjEX-0000O4-LN; Sun, 17 Apr 2016 11:43:13 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1arjED-0001XF-8V; Sun, 17 Apr 2016 11:42:53 +0200
Received: from x4db1b905.dyn.telefonica.de (x4db1b905.dyn.telefonica.de
 [77.177.185.5]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 17 Apr 2016 11:42:53 +0200
In-Reply-To: <1460823230-45692-3-git-send-email-rappazzo@gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1460886193.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291749>


Quoting Michael Rappazzo <rappazzo@gmail.com>:

> +test_expect_success 'GIT_DIR=../.git, core.bare = false:  
> is-bare-repository' '
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	test_config -C "$(pwd)"/.git core.bare false &&
> +	GIT_DIR=../.git test_stdout false git -C work rev-parse  
> --is-bare-repository
> +'

Here and in the following tests as well: some shells don't cope that well
with a one-shot environmental variable set in front of a shell function.
See commit 512477b17528:

     tests: use "env" to run commands with temporary env-var settings

     Ordinarily, we would say "VAR=VAL command" to execute a tested
     command with environment variable(s) set only for that command.
     This however does not work if 'command' is a shell function (most
     notably 'test_must_fail'); the result of the assignment is retained
     and affects later commands.

     To avoid this, we used to assign and export environment variables
     and run such a test in a subshell, like so:

             (
                     VAR=VAL && export VAR &&
                     test_must_fail git command to be tested
             )

     But with "env" utility, we should be able to say:

             test_must_fail env VAR=VAL git command to be tested

     which is much shorter and easier to read.
