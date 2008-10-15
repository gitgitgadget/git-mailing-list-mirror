From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: [gambit-list] Separating generated files? (Re: Mercurial -> git)
Date: Wed, 15 Oct 2008 19:28:20 +0200
Message-ID: <48F62834.9080102@pflanze.mine.nu>
References: <E6D34628-783D-4597-8B00-C10F27F63BE2@iro.umontreal.ca>	<48F5D86B.6040501@pflanze.mine.nu>	<fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com> <vpqiqrt3mgs.fsf@bauges.imag.fr> <48F61D77.3080100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Marc Feeley <feeley@iro.umontreal.ca>,
	Gambit List <Gambit-list@iro.umontreal.ca>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 19:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqABo-0001wY-70
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 19:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYJOR22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 13:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbYJOR21
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 13:28:27 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:45797 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751671AbYJOR21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 13:28:27 -0400
Received: (qmail 28871 invoked from network); 15 Oct 2008 17:28:24 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 15 Oct 2008 17:28:24 -0000
Received: (qmail 12340 invoked from network); 15 Oct 2008 17:28:21 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 15 Oct 2008 17:28:21 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48F61D77.3080100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98290>

Michael J Gruber wrote:
> I wonder whether a clever use of "excludes" and GIT_DIR would allow
> tracking the different filesets in the same dir, but using different
> repos. I'm just afraid it's a fragile setup, in the sense that it relies
> on config stuff which is not tracked (and thus not reproduced
> automatically on clone).

I expect that using a superproject repository to tie together the two 
repositories is good and necessary because it is the link that allows to 
specify which commit in the repo of generated files belongs together 
with a commit in the repo of source files. So just using two separate 
repositories without making them submodules of a superproject does not 
seem to be a good idea to me.

Once there is a superproject repository, one could also commit config 
files of the submodules into it (I'm not sure what that will buy 
though--.gitignore is outside and can committed anyway, at least as long 
as not both repositories are overlaid as you suggest).

You're probably right that strictly speaking, there is no need to move 
generated files out into a separate directory tree; but I think doing 
the move would be worthwhile since it takes away one level of complexity 
(you can then access the build/.git repository without the need of 
setting GIT_DIR), and because it may be a good idea anyway (for example 
it will be easier to grep the sources without getting hits from the 
generated files). [Also, the exclude patterns wouldn't be easy, as we 
couldn't really just exclude all *.c files from the view of the source 
repository, since there are also some hand-crafted ones; the excludes 
would need full paths which would have to be kept up to date manually, 
unless we wanted to live with the fact that newly created manual .c 
files would be added using "git add -f".]

Christian.
