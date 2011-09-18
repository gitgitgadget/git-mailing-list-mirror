From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [RFC] fast-import: note deletion command
Date: Mon, 19 Sep 2011 02:07:46 +0600
Message-ID: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 18 22:07:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5NeZ-0007id-FH
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518Ab1IRUHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 16:07:47 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62178 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273Ab1IRUHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 16:07:46 -0400
Received: by qyk30 with SMTP id 30so2132678qyk.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=37bDXEsj6btJ/LDV7TIWaHcaROE6Yb4dkvXbr2UtAEo=;
        b=JSH+Z9niNWGvvqIGvu05buchzVFFUi9HSB5scX/kbOrMFBDHeEOlaOD+9V1PdBHCx6
         C42eoZPirQVy/LE6vh+4ktQPzISZBg4qFNI62jAJuAkfYiIbabT8FQkG000o0qw3GLZs
         c2dY2dXxLNUiYlI+ClH/HJhqRgVjEFMxBwcys=
Received: by 10.229.69.206 with SMTP id a14mr1366516qcj.54.1316376466294; Sun,
 18 Sep 2011 13:07:46 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Sun, 18 Sep 2011 13:07:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181634>

Hi,

fast-import is able to write notes provided a command
N <note_content_data_specification> <commit_specification>

There is no documented command to delete a note. It can't be
easily replaced with Delete command on notes tree because
of notes fanout.

But fast-import interprets 0{40} data_specification as a note
deletion command. It is consistent with fast-import internals
where null_sha1 is used for absent/unknown object. But is
not consistent with file Modify command nor looks like a common
convention in git ui.

So the questions are:
- should 0{40} not be treated as deletion toggle? Downside is that
it is used as one in t/t9301-fast-import-notes.sh.
- how should a documented way to delete notes look like?
ND commit_sha1 # One may think there are also NC, NR, NM
N delete commit_sha1
# Only :mark, full-40-byte-sha1 and 'inline' are allowed currently.
# So no clashes arise, but then one may also want M 'delete' path
# command to work too.
