From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 13/22] documentation: add documentation of the index-v5 file format
Date: Thu, 11 Jul 2013 13:39:10 +0200
Message-ID: <87mwptcom9.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-14-git-send-email-t.gummerer@gmail.com> <CACsJy8ALSBPq1+TP_YxJ=ecUwpKRY-i2O=+q8qMjtXbjShg3mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:39:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFDU-00026t-5S
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab3GKLjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:39:16 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:36400 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3GKLjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:39:15 -0400
Received: by mail-ee0-f52.google.com with SMTP id c50so5496928eek.25
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=z8+e/IYRR61QGJ/yWG8k+lkcPv0Nj1oDHMnXCXeAsmw=;
        b=Q9Pj/gbMwoPc8/ys2FVg8WrEllqdpVE+Skk7ZjFT+JlWePeKFEs5wlwPXIwOLcZ01X
         vHSZpy4RnjgP4egR780aRaE0Ntd73wk5m8Jj9HBVTU+Zfy31ogn6KETq/qzEWndc/Axh
         DzB1RShsYx23lih8cAHvUtUHBTPTo6Q8o2PRorqUvrtw5JTlSReGzCT/jjbHSElEF2q0
         6lhU2I26/rQ5yb0Z9DAulE3H/a8sJgAivNBsd6IMhYhsPr5aIe2mCBQv9tlrFJqN3lZo
         yyYzeEkb+xT6NgSU6cwh4Gpumkx8dvs2AQndqh6oomkza/ABIaVzZuC2xOCAvIGLOLtG
         Yodg==
X-Received: by 10.15.94.11 with SMTP id ba11mr41407870eeb.101.1373542753609;
        Thu, 11 Jul 2013 04:39:13 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id n42sm68287319eeh.15.2013.07.11.04.39.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 04:39:12 -0700 (PDT)
In-Reply-To: <CACsJy8ALSBPq1+TP_YxJ=ecUwpKRY-i2O=+q8qMjtXbjShg3mA@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230092>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Jul 7, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +== File entry (fileentries)
>> +
>> +  File entries are sorted in ascending order on the name field, after the
>> +  respective offset given by the directory entries. All file names are
>> +  prefix compressed, meaning the file name is relative to the directory.
>> +
>> +  filename (variable length, nul terminated). The exact encoding is
>> +    undefined, but the filename cannot contain a NUL byte (iow, the same
>> +    encoding as a UNIX pathname).
>> +
>> +  flags (16-bits): 'flags' field split into (high to low bits)
>> +
>> +    assumevalid (1-bit): assume-valid flag
>> +
>> +    intenttoadd (1-bit): intent-to-add flag, used by "git add -N".
>> +      Extended flag in index v3.
>> +
>> +    stage (2-bit): stage of the file during merge
>> +
>> +    skipworktree (1-bit): skip-worktree flag, used by sparse checkout.
>> +      Extended flag in index v3.
>> +
>> +    smudged (1-bit): indicates if the file is racily smudged.
>> +
>> +    10-bit unused, must be zero [6]
>> +
>> +  mode (16-bits): file mode, split into (high to low bits)
>> +
>> +    objtype (4-bits): object type
>> +      valid values in binary are 1000 (regular file), 1010 (symbolic
>> +      link) and 1110 (gitlink)
>> +
>> +    3-bit unused
>> +
>> +    permission (9-bits): unix permission. Only 0755 and 0644 are valid
>> +      for regular files. Symbolic links and gitlinks have value 0 in
>> +      this field.
>> +
>> +  mtimes (32-bits): mtime seconds, the last time a file's data changed
>> +    this is stat(2) data
>> +
>> +  mtimens (32-bits): mtime nanosecond fractions
>> +    this is stat(2) data
>> +
>> +  file size (32-bits): The on-disk size, trucated to 32-bit.
>> +    this is stat(2) data
>> +
>> +  statcrc (32-bits): crc32 checksum over ctime seconds, ctime
>> +    nanoseconds, ino, dev, uid, gid (All stat(2) data
>> +    except mtime and file size). If the statcrc is 0 it will
>> +    be ignored. [7]
>> +
>> +  objhash (160-bits): SHA-1 for the represented object
>> +
>> +  entrycrc (32-bits): crc32 checksum for the file entry. The crc code
>> +    includes the offset to the offset to the file, relative to the
>> +    beginning of the file.
>
> Question about the possibility of updating index file directly. If git
> updates a few fields of an entry (but not entrycrc yet) and crashes,
> the entry would become corrupt because its entrycrc does not match the
> content. What do we do? Do we need to save a copy of the entry
> somewhere in the index file (maybe in the conflict data section), so
> that the reader can recover the index? Losing the index because of
> bugs is big deal in my opinion. pre-v5 never faces this because we
> keep the original copy til the end.
>
> Maybe entrycrc should not cover stat fields and statcrc. It would make
> refreshing safer. If the above happens during refresh, only statcrc is
> corrupt and we can just refresh the entry. entrycrc still says the
> other fields are good (and they are).

The original idea was to change the lock-file for partial writing to
make it work for this case.  The exact structure of the file still has
to be defined, but generally it would be done in the following steps:

  1. Write the changed entry to the lock-file
  2. Change the entry in the index
  3. If we succeed delete the lock-file (commit the transaction)

If git crashes, and leaves the index corrupted, we can recover the
information from the lock-file and write the new information to the
index file and then delete the lock-file.
