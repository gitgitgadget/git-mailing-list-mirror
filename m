From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to migrate a complex directory structure from SVN to GIT?
Date: Wed, 18 Jan 2012 11:43:48 +0100
Message-ID: <4F16A264.9030503@alum.mit.edu>
References: <1326828837924-7197567.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Asuka <c.bauers@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 18 11:43:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnSzk-0004mV-Ke
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 11:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab2ARKnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 05:43:52 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36898 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab2ARKnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 05:43:51 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0IAhmko018068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Jan 2012 11:43:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <1326828837924-7197567.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188744>

On 01/17/2012 08:33 PM, Asuka wrote:
> I would like to migrate my svn repository to git. The structure looks like
> the following:
> 
> svn
>    |_Project1
>          |_subproject1
>                |_branches
>                       |_branch1
>                       |_branch2
>                |_trunk
>                |_tags
>                       |_tagv1
>    |_Non-JavaProject
>          |_subproject
>    |_Project2
>           |_AnotherSubproject
>                |_SubSubproject
>           |_Subproject2
>                |_branches
>                |_tags
>           |_Subproject3
>                |_trunk
>           |_Subproject4
>                |_Subsubproject
>                        |_branches
>                        |_tags
>                        |_trunk
> 
> I would like to migrate all branches and tags

This can be confusing because Subversion confounds the namespace for
lines of development (trunk, branches, and tags) with those of filename
paths.  The basic rule is: normally each trunk/branches/tag triplet
corresponds to a single project, and each project should be converted
into a separate git repository.

In your case it is hard to tell where the project boundaries are without
more information.

If some projects don't have branches or tags, that is OK; you can
configure git-svn pretty flexibly.

If some have branches and/or tags but not trunk, give it a try; I'm not
sure whether git-svn can handle it.

If some subprojects (including their trunk/branches/tags directories)
are nested within the source code of the enclosing projects (thus
entangling the namespaces), then you have chaos even in the Subversion
world.  Such a mess can probably also be rescued, but it will be more
involved.  For example, you might use svndumpfilter to strip
improperly-nested projects out of (copies of) your Subversion repository
*before* converting the enclosing project, or play some kind of
git-filter-branch tricks *after* the conversion.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
