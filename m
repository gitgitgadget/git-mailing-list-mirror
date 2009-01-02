From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: Handle actions with no project in evaluate_path_info
Date: Fri, 2 Jan 2009 01:46:36 +0100
Message-ID: <cb7bb73a0901011646n6a1368caq797a5f2849daec77@mail.gmail.com>
References: <a899d7ef0812272326j1a407c30k936bf8d8975c9063@mail.gmail.com>
	 <200901020058.30748.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Devin Doucette" <devin@doucette.cc>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 01:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIYCn-0001Bk-VZ
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbZABAql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbZABAqk
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:46:40 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:47650 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbZABAqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 19:46:39 -0500
Received: by ewy10 with SMTP id 10so6566084ewy.13
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 16:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IGnMoBR/v/b8ognoIT2ldb2xdKiXxLhskmTC18O8Myo=;
        b=UAkwA4NDx+8jlkzhEPhFOyH0JKl4JxsRJwCne/C805zoW6w854dplrI55tFCn+VMDq
         eIaj8E33kmugZaZOE31HWg2nRGvMSsM/2lEogxnJuB4zTa2xnmNjpk6upzJxZwta33+8
         bkYOMWOK4WRHzfybAmnWEOnLMbwbxgXeIyiNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aSVrbFFmfStBR8hlJZkCi5e9wQoF5loYghDsc1195LEfAqm3hVR2cig+yesJsg3e+C
         yMGoYdwVXLNaRmmcWSSikS9rDkxtYrMvRBYDCNfyHrJ0DzLpiOXH306olrjLpDjB2X/d
         mnGKkHgWOuq8AU4u31IE+Nyg8iYxuR9rZNCks=
Received: by 10.210.43.11 with SMTP id q11mr7062655ebq.140.1230857196146;
        Thu, 01 Jan 2009 16:46:36 -0800 (PST)
Received: by 10.210.72.3 with HTTP; Thu, 1 Jan 2009 16:46:36 -0800 (PST)
In-Reply-To: <200901020058.30748.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104351>

On Fri, Jan 2, 2009 at 12:58 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Truth to be told we parse action parameter in path_info only since
> d8c2882 (gitweb: parse project/action/hash_base:filename PATH_INFO)
> by Giuseppe Bilotta (CC-ed; I think he is correct person to give
> Ack for this patch). Earlier only "default" actions could be expressed
> using only path_info, and project-less 'opml' and 'project_index'
> actions are not default actions for projectless URL, so there was no
> such problem then.

Actually, the early bailout was sort of intentional. The problem is
the ambiguity: does git.example.com/opml refer to the opml project, or
does it refer to the opml action?

HOWEVER, href() *does* create the opml action as git.example.com/opml,
so gitweb is currently broken in the sense that ti doesn't correctly
parse its own pathinfo output. So the question is: shall we go with
this patch, preventing pathinfo from working for projects named like a
no-project gitweb action, or should we fix href() to not generate
pathinfo unless project is defined?

>> -     return unless $project;
>> -     $input_params{'project'} = $project;
>> +     $input_params{'project'} = $project if $project;

Note that if this patch is accepted, we probably need an appropriate
patch in href() anyway to use query params for projects named like
no-project actions.

-- 
Giuseppe "Oblomov" Bilotta
