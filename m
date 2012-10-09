From: Ralf Jung <post@ralfj.de>
Subject: gitweb bug: Existence if hidden repositories is leaked
Date: Tue, 09 Oct 2012 11:28:53 +0200
Message-ID: <5073EE55.7010809@ralfj.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 11:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLWEw-0005h6-VM
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 11:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2JIJgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 05:36:23 -0400
Received: from ralfj.de ([85.214.220.216]:38261 "EHLO ralfj.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673Ab2JIJgU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 05:36:20 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2012 05:36:20 EDT
Received: from [192.168.1.151] (p54A5A12C.dip.t-dialin.net [84.165.161.44])
	by ralfj.de (Postfix) with ESMTPSA id 703CD14F81E3
	for <git@vger.kernel.org>; Tue,  9 Oct 2012 11:28:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207312>

Hi list,

I am using gitweb, git-daemon and gitolite on my Debian Squeeze server.
I have some repositories however that I do not want to be available to
the public (currently, that is gitolite-admin only). Those repositories
do not have a "git-daemon-export-ok" file, and the gitweb config contains

# path to git projects (<project>.git)
$projectroot = "/home/git/repositories";
# only show repos which allow daemon access
$export_ok = "git-daemon-export-ok";

I am also using pathinfo to get prettier URLs. However, if I now try to
access gitolite-admin.git in the browser, I get "404 Project Not Found".
If I try to access some repository which dos not actually exist, I am
redirected to the project index. This way, the existence of hidden
repositories is disclosed.

The problem is in the function evaluate_path_info which uses
check_head_link to find out which part of the URL is the project.
Replacing this by check_export_ok fixes the problem.

Kind regards,
Ralf

PS: Please keep me in CC, I am not subscribed.
