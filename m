From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 14:50:53 -0700
Message-ID: <7vu04mucaq.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com> <ebauq1$kcb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 23:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAZTX-0000qo-8u
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 23:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWHHVu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 17:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWHHVu4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 17:50:56 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61826 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965020AbWHHVuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 17:50:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808215055.JAYN12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 17:50:55 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebauq1$kcb$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	08 Aug 2006 23:13:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25092>

Jakub Narebski <jnareb@gmail.com> writes:

> Summary of discussion: using *_read_* to distinguish between git calling
> commands, and file reading commands is not a good idea. So now the
> guideline is to be more fluid with *_get_* vs *_read_* subroutine naming:
> it would depend on the noun after _get_ or _read_.

I suspect it is summary of discussion between you and yourself ;-).

I still do not think get_* vs read_* mean anything.  You get
information somehow, and maybe reading from a pre-existing file
might be one way to do so, or reading from a pipe to a command
might be another way to do so, but it does not change an iota
that you are retrieving information.

> Proposed renames:
> 1. Renames I think everybody would agree on
>  - git_get_referencing => format_mark_referencing
>
>  - date_str => parse_date
>  - git_read_tag => parse_tag
>  - git_read_commit => parse_commit
>
>  - git_blob_plain_mimetype => blob_plain_mimetype

Does it matter that the function is used in blob-plain?  In
other words, how would this function, blob-plain-mimetype, be
different if we were to have another function called blob-mimetype?

How about calling it "guess-mimetype"?

>  - git_page_nav => git_print_page_nav
>  - git_header_div => git_print_header_div

Both sounds sane (I would have said "git-show-blah" if I were
doing this myself, though).

>  - git_read_head => git_get_head_hash
>  - git_read_hash => git_get_hash_by_ref

Both sounds sane.

>  - git_read_description => git_project_description

No verbs in the renamed one feels awkward.
git-get-project-description, perhaps.

>  - git_read_projects => git_get_projects_list or git_list_projects

list-projects is probably the most natural name for something
that gives a list to the end user.  If you are getting the list
in-core for further processing, the name is misleading.

Perhaps git-get-projects-list is more appropriate.

>  - read_info_ref => git_read_info_refs => git_get_references
>  (this one depend too much on implementation, which might be changed to 
>   parsing 'git ls-remotes .' output instead of relying on info/refs being
>   up to date thanks to git-update-server-info in post-update hook, 
>   and on its format).

I am not worried too much about the format (because clone/fetch
over http depends on it), but reading from ls-remote self would
make it unnecessary to run update-server-info if a repo is not
served over http but is shown over gitweb.

>  - age_string => ????

Good name as is, but if you want consistent, it formats the
timestamp into age, so it would fall into format-blah family.
