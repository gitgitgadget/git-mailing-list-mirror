From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last change
Date: Sat, 14 Apr 2012 15:16:01 +0200
Message-ID: <201204141516.02719.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <201204041631.42905.jnareb@gmail.com> <20120404162208.GN10461@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 15:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ2pq-0006bl-UU
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 15:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab2DNNQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 09:16:09 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63562 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab2DNNQG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 09:16:06 -0400
Received: by wibhj6 with SMTP id hj6so7299498wib.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=f07eKXIkqCDEzG53fspeqJIHVaKUvRqiMUKx5RZipBs=;
        b=Hp0EzjkOxMqNpObQrP+kXMPXSg47uSm/1SJ6ywL6Wgde9CNhw0jQFRuGLv7RVW5pOJ
         RPgiWUaci1dMWbMhpnMDGz+eS7kwnOpK1vlJZmYLzkCEsy/qRzezt2YstAOf2z1QxWOQ
         VTwSuuyN/5jhopl8NAOJ1RfBg6tNCHeT+SvGwy/s7uXPVcGu+CVF7+XTGlZSJC/6Ku7N
         m8yTEj/QzSinm76zKMUBvlekvVIUCPf6YtDnFrrz46hzVIcbMbx7G2YWDRnSadiA7y8S
         ZXgm6S6W7t6gDQJAB7UzFRW/h2RALHF+X44zACsaG0IslZQtT8uUxyrub5EEe31GF7iN
         yhPw==
Received: by 10.180.88.67 with SMTP id be3mr4091592wib.20.1334409365367;
        Sat, 14 Apr 2012 06:16:05 -0700 (PDT)
Received: from [192.168.1.13] (addh222.neoplus.adsl.tpnet.pl. [79.184.59.222])
        by mx.google.com with ESMTPS id ca3sm4331086wib.6.2012.04.14.06.16.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 06:16:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120404162208.GN10461@camk.edu.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195491>

I'm sorry for the delay answering.

On Wed, 4 Apr 2012, Kacper Kornet wrote:
> On Wed, Apr 04, 2012 at 04:31:42PM +0200, Jakub Narebski wrote:
>> On Wed, 4 April 2012, Kacper Kornet wrote:
>>> On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
>>>> On Tue, 3 Apr 2012, Kacper Kornet wrote:
 
>> Perhaps it would be better to say it like this:
>> 
>>   $no_list_age::
>>   	If true, omit the column with date of the most current commit on the
>>   	projects list page. [...]
>> 
>> It is true that it can save a bit of I/O: the git_get_last_activity()
>> examines all branches (some of which are usually loose), and must hit
>> the object database, unpacking/getting commit objects to get at commit
>> date.
>> 
>> But the fact that it also saves a fork (a git command call) per repository
>> reminds me of something which I missed in first round of review, namely
>> that generating 'age' and 'age_string' fields serve also as a check if
>> repository really exist.
>> 
>> So either we document this fact, or use some other way to verify that
>> git repository is valid.
> 
> I think that git_project_list_body always works with the list returned
> by git_get_projects_list. And git_get_projects_list validates if the
> path is a git repository. So it should not be a problem. Please correct
> me, if I am wrong.
 
If $projects_list points to plain file, git_get_projects_list() just
gets list of projects (and project owners) from $projects_list file
by reading and parsing this file.  No verification that repository
exists is done.

If $projects_list points to directory (which is the default), then
git_get_projects_list() scans starting from $projects_list directory
for somtehing that _looks like_ git repository with check_head_link()
via check_export_ok().  But you still can encounter something that
looks like git repository (has "HEAD" file in it), but isn't.


So we would probably want to have said variable or set of variables
describe three states:

* find date of last change in repository with git-for-each-ref called
  by git_get_last_activity(), which as a side effect verifies that
  repository actually exist.  

  git_get_last_activity() returns empty list in list context if repo
  does not exist, hence

  	my (@activity) = git_get_last_activity($pr->{'path'});
  	unless (@activity) {
  		next PROJECT;
  	}

* verify that repository exists with "git rev-parse --git-dir" or
  "git rev-parse --verify HEAD", or "git symbolic-ref HEAD", redirecting
  stderr to /dev/null (we would probably want to save output of the
  latter two somewhere to use it later).
  
  That saves I/O, but not fork.

* don't verify that repository exists.


Though perhaps the last possibility isn't a good idea, so it would be
left two-state, as in your patch. 

>>> [...]. Especially that I would like also to introduce
>>> option to prevent printing repository owner everywhere.
>>> 
>> Well, because this patch affects gitweb configuration, and because we
>> need to preserve (as far as possible) the backward compatibility with
>> existing gitweb configuration files we need to be careful with changes.
>> 
>> Perhaps instead of $no_age_column that can be single configuration
>> variable like @excluded_project_list_fields instead of one variable
>> per column.  Somebody might want to omit project description as well
>> (though then project search must be limited to project names only).
>> Though this approach will have problem that some of columns simply
>> have to be present... maybe one variable per column (perhaps hidden
>> in a hash) is a better solution.
> 
> I thought about two different variables as that would have a slightly
> different functionality. While I want to get rid off Last Change from
> the projects list page, I still want to get this information on pages of
> single repositories. On the other hand I don't want repository owner to
> be shown anywhere.

Ah, in this case we want to keep $dont_show_repo_age / $no_age_column
(or something like that) separate from $no_owner... and in this case
these features can be controlled by separate scalar configuration
variables.


-- 
Jakub Narebski
Poland
