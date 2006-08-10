From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Thu, 10 Aug 2006 09:57:04 +0200
Organization: At home
Message-ID: <ebeorr$amq$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <ebauq1$kcb$1@sea.gmane.org> <7vu04mucaq.fsf@assigned-by-dhcp.cox.net> <ebb3fm$2md$1@sea.gmane.org> <ebdi1v$cv5$1@sea.gmane.org> <7v3bc5397r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 10 09:57:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5Pg-00073y-Bf
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 09:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWHJH5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 03:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWHJH5E
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 03:57:04 -0400
Received: from main.gmane.org ([80.91.229.2]:24227 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161081AbWHJH5C (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 03:57:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GB5PU-00072N-Qc
	for git@vger.kernel.org; Thu, 10 Aug 2006 09:56:56 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 09:56:56 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 09:56:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25162>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Subroutines in gitweb: <current name> => <proposed rename>.
> 
> If it is not too much trouble, having a few line summary of what
> each of the sub does would greatly help judging if the names are
> appropriate.

Subroutines name guideline, revised:
* git_ prefix for subroutines related to git commands,
  or to gitweb actions
* git_get_ prefix for inner subroutines calling git command
  and returning some output
* parse_ prefix for subroutines parsing some text, or reading and
  parsing some text into hash or list
* format_ prefix for subroutines formatting/post-processing some
  HTML/text fragment
* _get_ infix for subroutines which return result
* _print_ infix for subroutines which print fragment of output
* _body suffix for subroutines which outputs main part (body)
  of related action
* _nav suffix for subroutines related to navigation bars
* _div suffix for subroutines returning or printing div element

Current gitweb subroutines, with proposed renames, and short summary.

* validate_input => is_valid_ref, is_valid_path (?)
  universal (too universal) parameter validation
* esc_param
  quote unsafe chars in link parameters
* esc_html
  escape to HTML, replace invalid uft8 characters
* unquote
  unquote filenames quoted and escaped by git
* untabify
  convert tabs (8 spaces wide tabstops) to spaces
* chop_str
  shorten string, removing characters entities as whole

* age_class
  CSS class for given age value (in seconds)
* age_string
  convert age in seconds to "nn units ago" string
* mode_str
  convert file mode in octal to symbolic file mode string
* file_type
  convert file mode in octal to file type string (directory, symlink,
  file, unknown)

* format_log_line_html
  format line of commit message or tag comment, hyperlinking commitids
  (perhaps in the future comittags, e.g. BUG(nn) support)
* git_get_referencing => format_mark_referencing (???)
  return HTML fragment generating marker of refs pointing to given object

* git_read_head => git_get_head_hash
  get HEAD ref of given project as hash
* git_read_hash => git_get_hash_by_ref
  get hash of given ref (e.g. refs/heads/next)
* git_get_hash_by_path
  get hash of given path at given ref
* git_get_type
  get type of given object (by hash)
* git_get_project_config
  return value of given variable in gitweb section
* git_get_project_config_bool
  return value of given variable in gitweb section, as boolean
* git_read_description => git_get_project_description
* git_read_projects => git_get_projects_list
  return list of projects (path, owner)
* read_info_ref => git_get_references
  return hashref of refs pointing to object given by hash key
* git_read_refs => git_get_refs_list
  list of hashrefs of parsed ref info
  (parsing to be separated into parse_ref subroutine)

* date_str => parse_date
  given epoch and (optionally) timezone return parsed date as hash
* git_read_tag => parse_tag
  given tag_id, return parsed tag as Perl hash
* git_read_commit => parse_commit
  given commit_id (and optionally commit_text to reuse), return parsed
commit

* get_file_owner
  return owner of given file, according to user id and gcos field
* mimetype_guess_file => ??? 
  reads and parses mime.types like file, return mimetype of given filename
* mimetype_guess => (to be incorporated in blob_mimetype)
  try $mimetypes_file, or /etc/mime.types
* git_blob_plain_mimetype => blob_mimetype
  return mimetype of given (by file descriptor and filename) blob
* git_get_paging_nav => ???
  return HTML fragment generating "HEAD * prev * next" page navigation
* git_page_nav => git_print_page_nav
  print "action" navigation bar, optionally with pager or formats below
* git_header_div => git_print_header_div
  prints div element of class "header" just below navigation bar
* git_print_page_path
  print div element of class "page_path" with current path
* git_diff_print => (to be made obsolete)
  print diff between two files, using /usr/bin/diff and temporary files

* git_header_html
  prints HTML header of gitweb output 
* git_footer_html
  prints HTML footer of gitweb output
* die_error
  prints gitweb error page

Subroutines printing table with shortlog, tags, heads respectively
* git_shortlog_body
* git_tags_body
* git_heads_body

Action subroutines
* git_project_list
* git_summary
* git_tag
* git_blame2 => git_blame (?)
* git_blame => git_annotate (?)
* git_tags
* git_heads
* git_blob_plain
* git_blob
* git_tree
* git_log
* git_commit
* git_blobdiff
* git_blobdiff_plain
* git_commitdiff
* git_commitdiff_plain
* git_history
* git_search
* git_shortlog
* git_rss
* git_opml

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
