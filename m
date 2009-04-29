From: Marcin Zalewski <marcin.zalewski@gmail.com>
Subject: Diftool problems
Date: Wed, 29 Apr 2009 12:15:49 -0400
Message-ID: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 18:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzCSX-0007uA-Ox
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 18:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbZD2QQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754410AbZD2QQL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 12:16:11 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:62554 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbZD2QQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 12:16:10 -0400
Received: by mu-out-0910.google.com with SMTP id i2so462804mue.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=44/pIDM8qX5pLJL3HpAFg/nDph+xm2/SrcMQa/XxTtc=;
        b=Ws8BkYDrDcafQO6RvYb59H8NKLCUMKhuSIL36wL68OV8RfK7MCr1XCJxKm6oDL/O/z
         0gfPDgltgfBpzm2PLJkNh5qvfu70F/1z+qpkiThGo1LlOgxRZgrSUDboDOQwgh5vsPZY
         0LtERQNcyN2z5B8Hy3mVtAKJRZ+eOczzpK/Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=PdOBeLBxcUi1NBxQPxPh089WF/17zdtLK+dd9Qomjyy5K/kAaa6nDZS2FSHSIb6b0U
         djSzLd52lIbVLJqWE2gfjDA+4bzEVjbAS+9FQOuZFA4C+gJY0KmBbG54msTGIp1/UKEs
         f2MNSLSjGegQzsMmWHYISIRjX7um8A76GlHXc=
Received: by 10.102.228.10 with SMTP id a10mr338834muh.26.1241021769182; Wed, 
	29 Apr 2009 09:16:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117903>

Hi,

When git-difftool calls a diff tool, it uses file names given to it by
git-diff. This is a problem because often one of the files to be
compared is the same as the file to be merged into. What I mean is
that, in the following fragment of the git-difftool--helper file, $1
and $2 (I think) may end up being the same:

launch_merge_tool () {
	# Merged is the filename as it appears in the work tree
	# Local is the contents of a/filename
	# Remote is the contents of b/filename
	# Custom merge tool commands might use $BASE so we provide it
	MERGED="$1"
	LOCAL="$2"
	REMOTE="$3"
	BASE="$1"

Git-mergetool creates a temporary file for merging, but git-difftool
does not. Since git-diff tools is not meant for merging anything, it
may seem that there is no problem. However, some merge tools (such as
ediff) do not like when the merge target is the same as one of the
files to be compared. I use the following emacs snippet by Theodore
Tso:

http://kerneltrap.org/mailarchive/git/2007/7/2/250505

With that emacs code, ediff refuses to do a diff with the way that
difftool is done now. I do not have a patch, but it seems that a
simple fix would be to copy the code that creates temporary files from
mergetool.

Cheers,
Marcin Zalewski
