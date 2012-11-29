From: Xypron <xypron.glpk@gmx.de>
Subject: Re: [PATCH] gitweb: git_summary - show $project in title
Date: Thu, 29 Nov 2012 22:07:52 +0100
Message-ID: <50B7CEA8.8050308@gmx.de>
References: <1352611258-11450-1-git-send-email-xypron.glpk@gmx.de> <20121112232513.GF10531@sigill.intra.peff.net> <7v625agwiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 22:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeBLe-0000oh-J8
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 22:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab2K2VIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 16:08:24 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:46323 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755192Ab2K2VIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 16:08:24 -0500
Received: (qmail invoked by alias); 29 Nov 2012 21:08:22 -0000
Received: from ip-88-153-184-9.unitymediagroup.de (EHLO [192.168.123.22]) [88.153.184.9]
  by mail.gmx.net (mp037) with SMTP; 29 Nov 2012 22:08:22 +0100
X-Authenticated: #41704822
X-Provags-ID: V01U2FsdGVkX1+Av3sm3cGAqwLPVALGXWJ0PBQP5pFl4tZN4vTE/u
	Tn+X/3KGEwaWUW
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.10) Gecko/20121027 Icedove/10.0.10
In-Reply-To: <7v625agwiv.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210876>

Thank you for your comments. In the appended version of the patch
the project title is escaped:

Subject: [PATCH] gitweb: git_summary - show $project in title

Gitweb pages are structured by divs of class title with grey background.
The shortlog, and the log page show the project name as the first title.
Page summary only shows an empty grey box above the project details.
This provides an inconsistent user experience.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e8812fa..be94b0b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6450,7 +6450,7 @@ sub git_summary {
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
-	print "<div class=\"title\">&nbsp;</div>\n";
+	print "<div class=\"title\">" . esc_html($project) . "</div>\n";
 	print "<table class=\"projects_list\">\n" .
 		"<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n";
         unless ($omit_owner) {
-- 
1.7.10.4


On 13.11.2012 01:46, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sun, Nov 11, 2012 at 06:20:58AM +0100, Henrich Schuchardt wrote:
>>
>>> Gitweb pages are structured by divs of class title with grey background.
>>> The shortlog, and the log page show the project name as the first title.
>>> Page summary only shows an empty grey box above the project details.
>>> This provides an inconstent user experience.
>>>
>>> This patch adds the missing project title.
>>>
>>> Signed-off-by: Henrich Schuchardt <xypron.glpk@gmx.de>
>>> ---
>>>  gitweb/gitweb.perl |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 10ed9e5..3e1c452 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -6451,7 +6451,7 @@ sub git_summary {
>>>  	git_header_html();
>>>  	git_print_page_nav('summary','', $head);
>>>  
>>> -	print "<div class=\"title\">&nbsp;</div>\n";
>>> +	print "<div class=\"title\">$project</div>\n";
>> I do not have any opinion on whether the intent of the change is good or
>> not, but shouldn't $project be run through esc_html() here?
> I think the answer is yes.  And if $project needs to be escaped, the
> git_feed function you fixed today has another codepath that needs to
> be fixed.  When git_get_project_description($project) returns undef,
> the description is taken from $project without any escaping.
>
>
>
