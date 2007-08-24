From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb-projects
Date: Fri, 24 Aug 2007 09:35:57 +0200
Message-ID: <200708240935.59089.jnareb@gmail.com>
References: <9e4733910708231438q4c454686p55cef622e61d6a2a@mail.gmail.com> <fal7gn$2vf$1@sea.gmane.org> <9e4733910708231711o71aa3953i349bce96c5eee8f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>
To: "Jon Smirl" <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 09:36:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTiL-00015r-Kg
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXHXHgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbXHXHgK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:36:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:16101 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbXHXHgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:36:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so563480nfb
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 00:36:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PKAEV9jk21sIvgmszd0iY1Jk50NHhkTB55wfe3NepmMl4ZRoJ1Qs+DLT7tlLyBWh4+Ttrr3ji9d97UL7OS9ljwhINhF+EW6/Ab4T81IBUpCeMMzhcz+Z5YwC04WDFmIqHfKBCrRpLjibzBY3M816fxrx+xQU6hQWRXWxjVZmNPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RuVVa1VvWT9ZQiNj3txVHQGa06MdNtIzGiI8cb/fINlGgySV13vPxxNMLou2Jdbs6Fnnmo95FKWWVuOwUGjQolT2E6Rvobh0QhZAp8iyto6bxcKdUKHzuB3urJsWB16UziK+60gglTMSR91N7rXm4H+o2yTg/F95I3UT9W5BytM=
Received: by 10.86.28.5 with SMTP id b5mr2038778fgb.1187940967128;
        Fri, 24 Aug 2007 00:36:07 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id c28sm5323661fka.2007.08.24.00.36.01
        (version=SSLv3 cipher=OTHER);
        Fri, 24 Aug 2007 00:36:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9e4733910708231711o71aa3953i349bce96c5eee8f0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56557>

On Fri, 24 August 2007, Jon Smirl wrote:
> On 8/23/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> [Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org]
>>
>> Jon Smirl wrote:
>>
>>> What is the magic incantation for encoding an email address along with
>>> the project owner name? From the source I see these strings need to be
>>> URL encoded (it doesn't seem to be in the doc)
>>
>> It is mentioned in gitweb/INSTALL, in the "Gitweb repositories" section

...and in the same file it is mentioned how to generate this file
from directory structure of repositories using gitweb, BTW.

>>> but now I'm getting XML errors.
>>>
>>> I tried this:
>>> mpc5200b.git Jon+Smirl+%3Cjonsmirl%2664%3Bgmail.com%3E

I think you don't need to escape '<', '>' and '@' here. The problem
was not with URL-escaping (or unescaping) the source, i.e. projects
list (projects index) file, but with proper HTML escaping when writing
it out: see patch below.

It would be enough to use

mpc5200b.git Jon+Smirl+<jonsmirl@gmail.com>

>> I guess that this might have nothing to do with URL-encoding of projects
>> index file, but with proper escaping in the gitweb, i.e. the string is
>> not wrapped in esc_html.
>>
>> In other words, it is a bug in the gitweb.

Please check if the patch below fixes your problem.

>>> Does this string really need to be URL encoded? Couldn't you split on
>>> the first space and then url encode it in the perl code? That would
>>> let me write the string in English instead of geek.
>>>
>>> mpc5200b.git Jon Smirl <jonsmirl@gmail.com>
>>
>> Not possible, as path to repository can contain spaces.
> 
> How about using a comma to separate them? Or let me quote the string?

The problem is that path to repository part can contain _any_ characters
except '\0'. The quoting would work, but splitting into path part (which
might need quoting) and owner part (which might also need quoting) is
non-trivial.

BTW. the URL-escaping is from original gitweb...

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Fri, 24 Aug 2007 09:12:16 +0200
Subject: [PATCH] gitweb: Fix escaping HTML of project owner in 'projects_list' and 'summary' views

This for example allows to put email address in the project owner
field in the projects index file (when $projects_list points to
file, and not directory), in the form of:

path/to/repo.git Random+J+Developer+<random@developer.example.org>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f282a67..9bee68e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3422,7 +3422,7 @@ sub git_project_list_body {
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
-		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
+		      "<td><i>" . esc_html(chop_str($pr->{'owner'}, 15)) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
 		      "<td class=\"link\">" .
@@ -3798,7 +3798,7 @@ sub git_summary {
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
-	      "<tr><td>owner</td><td>$owner</td></tr>\n";
+	      "<tr><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
 		print "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
 	}
-- 
1.5.2.5
