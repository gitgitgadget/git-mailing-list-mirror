From: "Holl, Marcus" <marcus.holl@sap.com>
Subject: Re: [PATCHv1 0/3] git-p4: fixing import with labels when commit is
 not transferred
Date: Mon, 14 Sep 2015 06:45:31 +0000
Message-ID: <D21C3878.15603%marcus.holl@sap.com>
References: <1440659938-12952-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Luke Diamand <luke@diamand.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 08:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbNdL-0004T6-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 08:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbbINGw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 02:52:56 -0400
Received: from smtpgw02.sap-ag.de ([155.56.66.97]:23561 "EHLO smtpgw.sap-ag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752405AbbINGvn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 02:51:43 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2015 02:51:42 EDT
Thread-Topic: [PATCHv1 0/3] git-p4: fixing import with labels when commit is
 not transferred
Thread-Index: AQHQ4Jiu1+qOhJh9vE24b8Fhbu7wNp47sLUA
In-Reply-To: <1440659938-12952-1-git-send-email-luke@diamand.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.4.4.140807
x-originating-ip: [10.21.40.112]
Content-ID: <4A7D6D411ADE5743BF8AE13C0EC33B64@exchange.sap.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277810>

Hi Luke,

>Marcus - if you're able to take a look at this and see if it
>fixes your problem that would be very useful.


Fix works for me.

Thanks a lot for fixing this issue.

Best regards,
Marcus

On 27/08/15 09:18, "Luke Diamand" <luke@diamand.org> wrote:

>Marcus Holl discovered that git-p4 fails to import labels sometimes.
>
>http://permalink.gmane.org/gmane.comp.version-control.git/273034
>
>It turns out there are at least two related problems.
>
>The first is that if git-p4 tries to import a P4 tag which references
>a commit that we don't know about at all (e.g. because the P4
>changelist was created before the point at which the repo was
>cloned) then when it tries to find the commit, the git rev-list
>command fails, and git-p4 terminates.
>
>This can be fixed by detecting the problem and ignoring that label.
>
>The second problem is that git-p4 can end up trying to find out
>about a commit which is still in the git fast-import stream and not
>yet processed. This is fixed by using fast-import "marks" to reference
>these commits, which avoids having to query for commits which don't
>yet exist. The normal path is used for commits that have not been
>imported during this run of the program (and so won't have marks).
>
>A test case is added to demonstrate the problem.
>
>Marcus - if you're able to take a look at this and see if it
>fixes your problem that would be very useful.
>
>Thanks,
>Luke
>
>Luke Diamand (3):
>  git-p4: failing test for ignoring invalid p4 labels
>  git-p4: do not terminate creating tag for unknown commit
>  git-p4: fix P4 label import for unprocessed commits
>
> git-p4.py                      | 25 +++++++++++++++--------
> t/t9811-git-p4-label-import.sh | 45
>++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 62 insertions(+), 8 deletions(-)
>
>-- 
>2.5.0.rc0
