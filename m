From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Sun, 27 Oct 2013 18:03:12 +0100
Message-ID: <526D4750.7040804@googlemail.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>	<526CA7D4.1070904@alum.mit.edu> <20131027071407.GA11683@leaf>	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>	<526CDC5C.40208@googlemail.com> <87zjpuznf1.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Josh Triplett <josh@joshtriplett.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 18:03:27 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaTkM-00028G-P4
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 18:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab3J0RDR (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 13:03:17 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63952 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab3J0RDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 13:03:15 -0400
Received: by mail-ee0-f46.google.com with SMTP id c1so2950752eek.5
        for <multiple recipients>; Sun, 27 Oct 2013 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VwedqfeYE0GpPjQlz9WVhclgBPl6B7jtIFNuR7mycK0=;
        b=m4+7pawRe8Z7yPb0xEOIBeLRlnE6kvEnGtbbILLQ67xs4QB0WCZye0t7Ez34KfUsbz
         1aFrB2t7y8e2JOwqxitHQV2iXV6Fe+J9bjMiqnFn+PQDXhiowWvlfrK/P3WZ4ymu7XWV
         S5xxXfOl6IPEIpurfy+mP9JRjRo/m2AMPI6jtF4b6VpJezmKnbNLxEsdK0+mHKOD0yij
         2VFirrJCaQuHGRQdRYsOb9gdxo2U3EWqfKI8zG9d3zgPJiasGKwFmaiUz5DC6oVUz9c5
         Ej7wIy8z4YGULD8ckZ1VM0A7/rrfQf9bNxrHATs3o/30I/2nQErl8PwqSj23XNE/Pm9l
         aL4g==
X-Received: by 10.15.98.194 with SMTP id bj42mr17656005eeb.12.1382893393879;
        Sun, 27 Oct 2013 10:03:13 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm46212626eev.14.2013.10.27.10.03.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Oct 2013 10:03:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <87zjpuznf1.fsf@thomasrast.ch>
X-Enigmail-Version: 1.5.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236805>

On 10/27/2013 05:30 PM, Thomas Rast wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
>> I assembled an overview table, which plots the long options of 
>> git commands by the short letters.
> [...]
>> (In case thunderbird messes it up, here it is again http://pastebin.com/raw.php?i=JBci2Krx)
>>
>> As you can see, f is always --force except for git-config, where it is --file
> 
> Woah!  Impressive work.  Did you autogenerate this?  If so, can we have
> it as a small make target somewhere?  If not, can you send a patch to
> put your table in Documentation somewhere?
> 

I thought about generating it by parsing the man pages, 
but I felt it would not be reliable enough and quite time consuming 
to come up with a parser. Parsing the C sources however also seemed time consuming,
so I decided to come up with this patch:
--8<--
Subject: [PATCH] parse-options: print all options having short and long form and exit

This patch basically only prints all options which have a long and a short form
and then aborts the program. A typical output looks like this:
./git-add
add,  n, dry-run
add,  v, verbose
add,  i, interactive
add,  p, patch
add,  e, edit
add,  f, force
add,  u, update
add,  N, intent-to-add
add,  A, all
---
 parse-options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 62e9b1c..b356ca9 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -500,6 +500,12 @@ int parse_options(int argc, const char **argv, const char *prefix,
 {
 	struct parse_opt_ctx_t ctx;
 
+	for (; options->type != OPTION_END; options++) {
+		if (options->long_name && options->short_name)
+			printf("%s,  %c, %s\n", argv[0], options->short_name, options->long_name);
+	}
+	exit(1);
+
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
-- 
1.8.4.1.605.g23c6912


Unfortunately we can only check git commands, which are written in C. 
You'll notice all the perl/shell written commands are missing (rebase, etc).
Also a few commands written in C cannot easily be picked up, as they do stuff
before calling parse_options. [typically something like "if (argc != 4) print_usage();"]
These commands are also not contained.

The generation of the table however was just a little python:

--8<--
#!/usr/bin/python

cmds="""git-add
git-apply
git-archive
git-branch
git-check-attr
git-check-ignore
git-check-mailmap
git-checkout
git-checkout-index
git-cherry
git-cherry-pick
git-clean
git-clone
git-column
git-commit
git-config
git-count-objects
git-credential-cache
git-credential-store
git-describe
git-fetch
git-fmt-merge-msg
git-for-each-ref
git-format-patch
git-fsck
git-fsck-objects
git-gc
git-grep
git-hash-object
git-help
git-init
git-init-db
git-log
git-ls-files
git-ls-tree
git-merge
git-merge-base
git-merge-file
git-merge-ours
git-mktree
git-mv
git-name-rev
git-notes
git-pack-objects
git-pack-refs
git-prune
git-prune-packed
git-push
git-read-tree
git-reflog
git-remote
git-repack
git-replace
git-rerere
git-reset
git-revert
git-rev-parse
git-rm
git-show
git-show-branch
git-show-ref
git-stage
git-status
git-symbolic-ref
git-tag
git-update-index
git-update-ref
git-update-server-info
git-verify-pack
git-verify-tag
git-whatchanged
git-write-tree"""

import subprocess

shorts={}
cmdoptions={}

for cmd in cmds.split("\n"):
	p = subprocess.Popen("./"+cmd, stdout=subprocess.PIPE)
	p.wait()
	lines = p.stdout.read()
	for line in lines.split("\n"):
		if not len(line):
			continue

		name, short, long = line.split(",")
		if not short in shorts:
			shorts[short] = len(long)
		else:
			shorts[short] = max(shorts[short], len(long))

		if not name in cmdoptions:
			cmdoptions[name] = {}
		cmdoptions[name][short] = long

longest_cmd = 0
for cmd in cmdoptions:
	longest_cmd = max(longest_cmd, len(cmd))

print " "*(longest_cmd-len("Name\\short")), "Name\\short",

for short in shorts:
	print "|" + " "*(1+shorts[short]-len(short)) + short,
print

for cmd in cmdoptions:
	print " "*(longest_cmd-len(cmd)), cmd,
	for short in shorts:
		s = ""
		if short in cmdoptions[cmd]:
			s = cmdoptions[cmd][short]
		print "|" + " "*(1+shorts[short]-len(s)) + s,
	print "  ", cmd

--8<--

I am not sure if we should add such code to the git code base, as it would need some cleanup. 
The existing table however would become outdated fast?
So I do not have a good idea, how such a table could be easily incorporated and kept up to date.

Thanks,
Stefan
