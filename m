From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [WIP/PATCH 0/8] svn-fe: support for text deltas
Date: Sat, 20 Nov 2010 13:21:53 -0600
Message-ID: <20101120192153.GA17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt1l-0000Sp-73
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab0KTTWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:22:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40558 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0KTTWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:22:06 -0500
Received: by yxf34 with SMTP id 34so3367838yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y1aeCoZ1wYyAMFo23Eh03dURmVWMXC88eRpL85N+AMo=;
        b=SBZz5nWGgxnw1EjxqSCsdpClC59Bel6KEdpdaDNZMEdhwFF+/aSjtT7nByH59SejzU
         atCoBtOHIZZH9bJgi63BkCfqX2Gdzq/sBrbapL8n/eDpaEhYf++pH/h/Cv/YZWZEhFbl
         coXnxmkgtDMA3XlboJ70IyOn0NNVNs5MMimWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YkuBP1Ok9Shy8wloXklQhldO9oEkArnqMjj0VzU2bnXBwNW0t2p5FBdT//LZzHYXD+
         fzsBNxy2clemiNqP1U4b6KH1DeiZPgRedbvSB4jn/ehmIdb16NUX/soF1+wiNTs/AvpS
         ToruV9XrZ6NglwW6MtvkbLnx9pyNSPqP1k9I8=
Received: by 10.150.91.18 with SMTP id o18mr6237725ybb.92.1290280924137;
        Sat, 20 Nov 2010 11:22:04 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 50sm1982307yhl.41.2010.11.20.11.22.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:22:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161831>

Jonathan Nieder wrote:
> Jonathan Nieder wrote:

>> This mini-series is part of an effort to get David and Ram's svn
>> import work integrated into mainline git[1].

The next chapter.  This adds handling of text deltas.  I broke it
in the process, though, as you can see with the attached test script:

	$ testme.sh http://svn.apache.org/repos/asf 100 asf.git
	[...]
	* Dumped revision 35.
	error: Preimage ends early
	fatal: cannot apply delta

Perhaps you can take this as a puzzle.  Where does the patch series
go wrong?

I like to think some of the cleanup will make this more maintainable
in the future, even if it is broken now.

Builds on the db/fast-import-cat-blob[1] and jn/svndiff0[2] topics.

Thoughts, improvements, complaints welcome.

David Barr (2):
  vcs-svn: Let caller set up sliding window for delta preimage
  vcs-svn: Implement text-delta handling

Jonathan Nieder (6):
  svn-fe: Prepare for strbuf use
  vcs-svn: Internal fast_export_save_blob helper
  vcs-svn: Introduce repo_read_path to check the content at a path
  vcs-svn: Introduce fd_buffer library
  vcs-svn: Read delta preimage from file descriptor
  vcs-svn: Teach line_buffer about temporary files

[1] Doesn't seem to be available on gmane.
The important part (patch 3) is, though:
http://thread.gmane.org/gmane.comp.version-control.git/161730
Should I re-send?

[2] http://thread.gmane.org/gmane.comp.version-control.git/151086/focus=158913
