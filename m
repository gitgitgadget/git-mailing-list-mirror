From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/23] http*: refactor (v6)
Date: Sat, 06 Jun 2009 11:04:35 -0700
Message-ID: <7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
References: <20090606164253.65a945ba.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 20:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD0GJ-0007IY-MI
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 20:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbZFFSEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbZFFSEk
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 14:04:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51797 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbZFFSEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 14:04:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606180435.PJWK20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jun 2009 14:04:35 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0i4b1c0054aMwMQ04i4bHr; Sat, 06 Jun 2009 14:04:35 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=2NLP4-4fE-gA:10 a=Ma-HhjepnY4A:10
 a=pGLkceISAAAA:8 a=EcCCc1JuAqJBavX1miQA:9 a=c_LzWw8JvHMObG61Fp8A:7
 a=NixNsB1mYKGR3vZAdgARdwGZDt4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090606164253.65a945ba.rctay89@gmail.com> (Tay Ray Chuan's message of "Sat\, 6 Jun 2009 16\:42\:53 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120929>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Junio, this replaces the entire 'rc/http-push' topic.
>
> Changes from the previous patch series:
>
> - add a list of functions added (patch #15)
>
> - use back the die()'s like in the original (patch #16)

Thanks, will queue, but please double check the result after I push it
out, as I found some other changes not listed above, relative to what was
queued in 'pu' (I am not complaining; I am asking your extra set of
eyeballs in case I somehow screwed up applying your series to my tree).

 - return value of fetch_indices() is 0 when http_get_info_packs() returns
   HTTP_MISSING_TARGET (both in http-push.c and http-walker.c);

 - break the function definition of run_request_queue() by removing "void"
   from the parameter list ("send out fetch requests on queue" -- no need
   to resend, I fixed it up again while applying);

 - update the error checking in transport.c:get_refs_via_curl() to make it
   look more similar to what are in fetch_indices() in both http-push.c and
   http-walker.c.

 - add unused "cleanup:" label to get_refs_via_curl() in transport.c
   (again no need to resend, I fixed it up while applying);

 - add back a few missing "->local = NULL" I screwed up while applying the
   previous series.

By the way, this is not your fault at all, but for a patch series
description, "shortlog" is a sucky way, as we can see below.  When you
talk about "patch #15", the reader cannot find which one you are talking
about but has to go back to the MUA, so the list is useless for that
purpose.

The output of "shortlog" in an e-mail message is wonderful when you are a
subsystem maintainer who bundles many people's work and are sending out a
pull request (i.e.  you are transferring the whole graph in "take it or
reject all" fashion, and you can refer to an individual changeset with its
commit object name).

But I think a cover letter to a patch series should serve as an easy index
from patch number to the title in some way, and "shortlog" is not suitable
for that eapecially for a multi-author series.

> Christian Couder (1):
>   http-push: fix missing "#ifdef USE_CURL_MULTI" around
>     "is_running_queue"
>
> Mike Hommey (7):
>   Don't expect verify_pack() callers to set pack_size
>   transport.c::get_refs_via_curl(): do not leak refs_url
>   http.c: new functions for the http API
>   transport.c::get_refs_via_curl(): use the new http API
>   http.c::http_fetch_ref(): use the new http API
>   http-push.c::remote_exists(): use the new http API
>   http-push.c::fetch_symref(): use the new http API
>
> Tay Ray Chuan (15):
>   t5540-http-push: test fetching of loose objects
>   t5540-http-push: test fetching of packed objects
>   http*: cleanup slot->local after fclose
>   http-push: send out fetch requests on queue
>   t5550-http-fetch: test fetching of packed objects
>   http-push, http-walker: style fixes
>   http-walker: verify remote packs
>   http*: copy string returned by sha1_to_hex
>   http-push: do not SEGV after fetching a bad pack idx file
>   http*: move common variables and macros to http.[ch]
>   http: create function end_url_with_slash
>   http*: add http_get_info_packs
>   http: use new http API in fetch_index()
>   http*: add helper methods for fetching packs
>   http*: add helper methods for fetching objects (loose)

>  http-push.c           |  579 ++++++++---------------------------------------
>  http-walker.c         |  533 +++++++------------------------------------
>  http.c                |  601 +++++++++++++++++++++++++++++++++++++++++++++++--
>  http.h                |   85 +++++++
>  pack-check.c          |    8 +-
>  t/t5540-http-push.sh  |   36 +++
>  t/t5550-http-fetch.sh |    8 +
>  transport.c           |   36 ++--
>  8 files changed, 905 insertions(+), 981 deletions(-)
