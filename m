From: Johan Herland <johan@herland.net>
Subject: Re: git notes and core.editor config
Date: Tue, 11 Jan 2011 11:31:17 +0100
Message-ID: <201101111131.17429.johan@herland.net>
References: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 11:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcbVf-0000Dp-Mj
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 11:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab1AKKbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 05:31:22 -0500
Received: from smtp.opera.com ([213.236.208.81]:58932 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab1AKKbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 05:31:20 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p0BAVHMi018990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jan 2011 10:31:17 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164925>

On Tuesday 11 January 2011, Jeenu V wrote:
> My core.editor value in $HOME/.gitconfig is set to
>
>   [core]
>       editor = vi "+set tw=72 spell"
>
> so that I've text width of 72 with spell check turned on. I haven't
> found problems with any git commands that invoke editor, but notes.
> 'git notes' seems to invoke the vi for me with 3 separate arguments
> instead of just one: "+set, tw=72, and spell". In other words, I
> don't think it honors shell quoting for editor config variable.
>
> Could this be a bug?

Indeed, it could, but I cannot immediately see what causes it. In 
current 'master', builtin/notes.c launches the editor like this:

  if (launch_editor(path, &(msg->buf), NULL)) ...

while builtin/commit.c lauches the editor like this:

  if (launch_editor(git_path(commit_editmsg), NULL, env)) ...

In both cases, the details of interpreting core.editor is left to 
git_default_core_config(), and passed to launch_editor() using the 
editor_program global variable. AFAICS there is no difference between 
how "notes" and "commit" interprets core.editor.

What Git version are you running?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
