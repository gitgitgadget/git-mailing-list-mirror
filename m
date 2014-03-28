From: Marat Radchenko <marat@slonopotamus.org>
Subject: [BUG] MSVC: error box when interrupting =?utf-8?b?YGdpdA==?= =?utf-8?b?bG9nYA==?= by quitting less
Date: Fri, 28 Mar 2014 08:35:31 +0000 (UTC)
Message-ID: <loom.20140328T093203-852@post.gmane.org>
References: <20130220195147.GA25332@sigill.intra.peff.net> <20130220200136.GH25647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 09:36:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTSGv-0006JJ-Na
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 09:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaC1IgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 04:36:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:47540 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbaC1IgF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 04:36:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WTSGf-0006B0-HN
	for git@vger.kernel.org; Fri, 28 Mar 2014 09:36:01 +0100
Received: from 185.6.245.138 ([185.6.245.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 09:36:01 +0100
Received: from marat by 185.6.245.138 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 09:36:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 185.6.245.138 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245371>

Jeff King <peff <at> peff.net> writes:

> 
> The write_or_die function will always die on an error,
> including EPIPE. However, it currently treats EPIPE
> specially by suppressing any error message, and by exiting
> with exit code 0.

This causes error box on Windows in MSVC=1 build:

git.exe!_invoke_watson(...) Line 132	C++
git.exe!_invalid_parameter(...) Line 85	C++
git.exe!_invalid_parameter_noinfo() Line 97	C++
git.exe!raise(int signum) Line 499	C
git.exe!mingw_raise(int sig) Line 1745	C
git.exe!check_pipe(int err) Line 9	C
git.exe!maybe_flush_or_die(_iobuf * f, const char * desc) Line 48	C
git.exe!log_tree_commit(rev_info * opt, commit * commit) Line 820	C
git.exe!cmd_log_walk(rev_info * rev) Line 344	C
git.exe!cmd_log(int argc, const char * * argv, const char * prefix) Line 637	C
git.exe!run_builtin(cmd_struct * p, int argc, const char * * argv) Line 314	C
git.exe!handle_builtin(int argc, const char * * argv) Line 487	C
git.exe!run_argv(int * argcp, const char * * * argv) Line 536	C
git.exe!mingw_main(int argc, char * * av) Line 616	C
git.exe!main(int argc, char * * argv) Line 551	C

"Should never happen", ha-ha.
