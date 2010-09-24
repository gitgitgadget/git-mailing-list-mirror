From: Avery Pennarun <apenwarr@gmail.com>
Subject: 'git diff' against files outside a git repo
Date: Fri, 24 Sep 2010 15:23:52 -0700
Message-ID: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:24:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGgl-0001RF-Es
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758309Ab0IXWYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:24:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57233 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758205Ab0IXWYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:24:14 -0400
Received: by wyb28 with SMTP id 28so2361208wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=17wYP+wMmH/rCpyHKud5ep1vQ9D+D820fl6/FCmSkGw=;
        b=X4kEgSoCoTjMIIX2M0gydvLCBusGwHa76okW1284QEeuryqmEt9rYxEq88jP35KvLQ
         yvCsnHDhIjEBng6nXnWUgqPzlH2RYaNSN7BJb3h/gdSPOz2BE11s9ipHrzpNn2qykvPe
         X0Z/xm1prmNJoWwmiaYaKT6BF7gRIYltuCVBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=t6oLZnPoND7agQY1mkmJNnhgCKMCW0b/DQpV/xJSKsLG0ZHiIbPXkBJhWXMi5y2vSl
         I170j69LysU5D8tS1JZZ+XI3enJnrCqxDXqjFmbtv0ZNnDjdyt1N/fhzLMlI7e0nIvje
         76XEsASm3X9nl4+BCCfCNY55hac2UtFNwdbYU=
Received: by 10.216.10.145 with SMTP id 17mr3324960wev.27.1285367053166; Fri,
 24 Sep 2010 15:24:13 -0700 (PDT)
Received: by 10.216.165.15 with HTTP; Fri, 24 Sep 2010 15:23:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157089>

Hi all,

I'm interested in using 'git diff' on some files that aren't actually
inside a git repo at all.  Specifically, the --color-words and
--word-diff-regex are really cool and I happen to have a use for them
on files that aren't stored verbatim in git.  As a whole, git's
implementation of diff seems to be the fastest-moving one out there,
so I'd rather use it instead of another random diff implementation.

(For the curious: the particular "files" I want to compare are
actually split into a hierarchical tree of blobs using bup's rolling
checksum and *then* stored in git.  Obviously I have to reassemble
them before I can diff them, which is fine and easy, but I then want
to run 'git diff' against them, which seems to not be so easy.)

(For the extremely curious: the particular files I want to diff are
mega-gigantic csv files from database dumps.  Because of bup's tree
format, I should be able to zoom in on just the overall part of the
file that has changed, then diff only that, which will be much faster
than running a diff algorithm against the whole file.  Essentially
O(log n) vs. the file size.)

Is there already a way to get 'git diff' to do this?

If not, would it be sensible to extend git-diff to do comparison
between two outside files?

Or should I stop trying to do this and use some other diff
implementation instead?

Another alternative would be to teach git directly how to act on
bup-style large objects, but that's... a lot of work.  And it's not
obvious that a patch to do so would be accepted anyhow, since
bup-style storage is necessarily not as space-efficient and is harder
to deltify.

Thanks,

Avery
