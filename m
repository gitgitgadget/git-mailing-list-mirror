From: Mike Hommey <mh@glandium.org>
Subject: Re: git-http-fetch segfault, curl 7.18.0
Date: Sun, 2 Mar 2008 20:23:55 +0100
Organization: glandium.org
Message-ID: <20080302192355.GA625@glandium.org>
References: <20080302190857.11027.qmail@28c5bbafb32cb2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 20:20:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVtjv-00042s-4H
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 20:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYCBTUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 14:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYCBTUM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 14:20:12 -0500
Received: from vuizook.err.no ([194.24.252.247]:57215 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbYCBTUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 14:20:10 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVtj6-0000X7-Bd; Sun, 02 Mar 2008 20:20:07 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVtmt-0000GI-85; Sun, 02 Mar 2008 20:23:55 +0100
Content-Disposition: inline
In-Reply-To: <20080302190857.11027.qmail@28c5bbafb32cb2.315fe32.mid.smarden.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75830>

On Sun, Mar 02, 2008 at 07:08:57PM +0000, Gerrit Pape wrote:
> Hi, as reported through http://bugs.debian.org/468836, I can reproduce
> with current maint branch on Debian/unstable, but I don't know whether
> it's a problem in curl, or in git.  Maybe anyone with some experience
> in curl can help on this?
> 
> gdb gives this
(...)

valgrind gives better insight:
==862== Invalid read of size 4
==862==    at 0x493B32: fill_active_slots (http.c:441)
==862==    by 0x493CF9: step_active_slots (http.c:459)
==862==    by 0x493D6E: run_active_slot (http.c:479)
==862==    by 0x493F8B: http_cleanup (http.c:296)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862==  Address 0x7c7c558 is 16 bytes inside a block of size 72 free'd
==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
==862==    by 0x493F47: http_cleanup (http.c:301)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862== 
==862== Invalid read of size 8
==862==    at 0x493B50: fill_active_slots (http.c:445)
==862==    by 0x493CF9: step_active_slots (http.c:459)
==862==    by 0x493D6E: run_active_slot (http.c:479)
==862==    by 0x493F8B: http_cleanup (http.c:296)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862==  Address 0x7c7c588 is 64 bytes inside a block of size 72 free'd
==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
==862==    by 0x493F47: http_cleanup (http.c:301)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862== 
==862== Invalid read of size 8
==862==    at 0x493BFD: process_curl_messages (http.c:74)
==862==    by 0x493CF4: step_active_slots (http.c:458)
==862==    by 0x493D6E: run_active_slot (http.c:479)
==862==    by 0x493F8B: http_cleanup (http.c:296)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862==  Address 0x7c7c548 is 0 bytes inside a block of size 72 free'd
==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
==862==    by 0x493F47: http_cleanup (http.c:301)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862== 
==862== Invalid read of size 8
==862==    at 0x493BF0: process_curl_messages (http.c:76)
==862==    by 0x493CF4: step_active_slots (http.c:458)
==862==    by 0x493D6E: run_active_slot (http.c:479)
==862==    by 0x493F8B: http_cleanup (http.c:296)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862==  Address 0x7c7c588 is 64 bytes inside a block of size 72 free'd
==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
==862==    by 0x493F47: http_cleanup (http.c:301)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862== 
==862== Invalid read of size 4
==862==    at 0x494372: get_active_slot (http.c:336)
==862==    by 0x49504A: start_object_request (http-walker.c:195)
==862==    by 0x495413: fill_active_slot (http-walker.c:321)
==862==    by 0x493B1C: fill_active_slots (http.c:433)
==862==    by 0x493CF9: step_active_slots (http.c:459)
==862==    by 0x493D6E: run_active_slot (http.c:479)
==862==    by 0x493F8B: http_cleanup (http.c:296)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862==  Address 0x7c7c558 is 16 bytes inside a block of size 72 free'd
==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
==862==    by 0x493F47: http_cleanup (http.c:301)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862== 
==862== Invalid read of size 8
==862==    at 0x494379: get_active_slot (http.c:337)
==862==    by 0x49504A: start_object_request (http-walker.c:195)
==862==    by 0x495413: fill_active_slot (http-walker.c:321)
==862==    by 0x493B1C: fill_active_slots (http.c:433)
==862==    by 0x493CF9: step_active_slots (http.c:459)
==862==    by 0x493D6E: run_active_slot (http.c:479)
==862==    by 0x493F8B: http_cleanup (http.c:296)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)
==862==  Address 0x7c7c588 is 64 bytes inside a block of size 72 free'd
==862==    at 0x4C20B2E: free (vg_replace_malloc.c:323)
==862==    by 0x493F47: http_cleanup (http.c:301)
==862==    by 0x494CA8: cleanup (http-walker.c:900)
==862==    by 0x4911D6: walker_free (walker.c:315)
==862==    by 0x44A149: cmd_http_fetch (builtin-http-fetch.c:81)
==862==    by 0x404247: handle_internal_command (git.c:248)
==862==    by 0x4049D4: main (git.c:412)

It seems there is something wrong going on with slots...

Mike
