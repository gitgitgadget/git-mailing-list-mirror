From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Mon, 18 Aug 2008 21:34:24 +0200
Message-ID: <48A9CEC0.2020100@gmail.com>
References: <4876B223.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 21:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAWD-0006go-RA
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 21:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764826AbYHRTe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 15:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758001AbYHRTe0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 15:34:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:15139 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764826AbYHRTeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 15:34:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1732260fgg.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=QZUvzNyirtr821feZlueDEE6LzykXujF1LV2PY+GBFs=;
        b=QFz89kx/4enj5zYIX8ewXAnTQigk9yP0LICj/7DB5NpvutKrYBi02yLasqrPl8ExP2
         bbAybSlShtGWb7+I2ipCX/IHcr3gzkjRAdrYZEY4c+cPa311/rmhjmSv8Of0Z1+9Cq7t
         alSewt34FLR+FbuqjEXaN2iJrIX4tdSiJCs54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=lJEwSs38li0aNXlAgxWqBCEsbalzyNmzhrp7nVawrnMqbJP/UMKUKqEaE9KQ+PzXPb
         eNpSNrT2zfhUHg5FBpr6gWAp4SlRtpxN3gRMBT06miXtwiXkEffIyACoWLgHwWh8xb4T
         kQ6U4roy4QBufi5B2c+9fpt6aUmDhHGciTTWw=
Received: by 10.180.244.19 with SMTP id r19mr3487631bkh.94.1219088061830;
        Mon, 18 Aug 2008 12:34:21 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.194.4])
        by mx.google.com with ESMTPS id y15sm7109204fkd.17.2008.08.18.12.34.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 12:34:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <4876B223.4070707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92726>

Lea Wiemann wrote:
> As follow-ups to this message, I'll be sending three patches for
> 
> 1) adding the Mechanize tests,
> 2) adding the Git::Repo API, and (the important part:)
> 3) making gitweb use the Git::Repo API, and adding caching to gitweb.

I'll be sending the next version of the patch series as a follow-up to
this message.  As the GSoC pencils-down deadline is in -0.5h, I'll try
to get the code out first and then I'll post some comments on a few
aspects it.

I unfortunately didn't end up being able to split up the third patch
(use Perl API in Gitweb, and add caching layer), since the two changes
are too intricately linked to be properly separated (I actually tried
splitting it two times, two different ways, and it just didn't work).
The only thing that's really not caching-specific to the third patch
(i.e. where using the Perl API merely prettifies the code) is where
Gitweb now uses $repo->get_sha1.  Those few occurrences are only a very
small part of the patch, and I don't think they'd warrant ripping it apart.

Here's the list of changes since the last patch series:


Patch 1/1 (Mechanize tests):

- typo


Patch 2/3 (Perl API):

- remove get_refs, get_path, and version methods

- rename cat_file to get_object

- remove unnecessary cmd_output and get_bidi_pipe methods -- they
  shouldn't be part of this API (because they don't fit into the
  design), and keeping and underscore-prefixing them isn't worth the
  code complexity -- so the Git::Repo methods now use 'open' calls
  directly

- rename the 'directory' options of RepoRoot->new, Repo->new, and
  RepoRoot->repo to 'repo_dir' and 'root_dir' respectively

- ignore (rather than die on) unrecognized header lines in tag/commit
  objects

- do not use unnecessary hash index optimization

- add design notes

- underscore-prefix assert_opts and assert_sha1

- remove dependency of the test suite (t9710) on non-standard modules;
  Git::Repo should now run on vanilla Perl 5.8

- respect PERL_PATH in test suite

- add "use perl 5.008" statement (so it dies for Perl <5.8) -- it
  needs Perl 5.8 for Unicode support

- do not "or" author/committer/tagger/type with '' (it's unnecessary
  and silly)

- improved documentation, per Jakub's suggestions mostly

- author, committer, tagger, and message now all return Unicode
  strings per <48809D31.5030008@gmail.com>

- some minor cleanups, typos

- remove warning about Git::Repo being unstable; this is a silly
  excuse that in theory allows you to make incompatible changes ("we
  told you so"), but in practice never holds up


Patch 3/3 (Gitweb):

- add installation note for the Git perl package to INSTALL

- accomodate removals/renamings in Git::Repo API

- remove two TODO markers in t9503 (gitweb tests) -- works now thanks
  to Git::Repo

- some minor cleanups, typos

- do not remove the Expires header (as was the case in the previous
  patch)

- remove option to assume case sensitive file system to unclutter the
  code -- the cache will now work on any file system

- elaborate on inefficient refs/ traversal code in
  get_last_modification method
