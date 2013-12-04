From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 00/11] Make reference pruning more configurable
Date: Wed,  4 Dec 2013 06:44:39 +0100
Message-ID: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5Nu-0007oC-M5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab3LDFw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:52:26 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43886 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158Ab3LDFwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:25 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2013 00:52:25 EST
X-AuditID: 1207440d-b7f4c6d000004a16-d8-529ec172024e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 26.3D.18966.271CE925; Wed,  4 Dec 2013 00:45:22 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCA5016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:21 -0500
X-Mailer: git-send-email 1.8.4.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsUixO6iqFt0cF6QwcIFJhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3RPv8iY8Ek+YretfeYGhh/
	inUxcnJICJhI7N3fxQRhi0lcuLeeDcQWErjMKPH5cHUXIxeQfZ5J4sOFrywgCTYBXYlFPc1g
	DSIC4hJvj89k72Lk4GAWiJA49LYEJCwsYCux+MgXdhCbRUBVYs2F9WA2r4CLRPuXX6wQuxQk
	Otf8Z5zAyL2AkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRojneXcw/l8n
	c4hRgINRiYc3gXNekBBrYllxZe4hRkkOJiVR3vrtQCG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vDZlQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvxgNAjYJFqemp
	FWmZOSUIaSYOThDBBbKBB2jDOpBC3uKCxNzizHSIolOMilLivJNBEgIgiYzSPLgBsBh9xSgO
	9I8wbwtIFQ8wvuG6XwENZgIabP5qFsjgkkSElFQDo8i1c1GzxLXCjW2vbwoQ41ax1jh3iUvM
	7Ijj++V8jsrRWxcssFl8IeVJ1OuqnFc3rsq8X7frRpNuyXkuw7ZHbubBfFXCKfVz1EyWrLj5
	RHmFwn4d5lobeba9teYW7EfDIxu3n2u+mXLbWeVMaI7ug+Ump+zm5+TWJKs3brp1nXNi4r6j
	Cj9OK7EUZyQaajEXFScCAFfvL5esAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238756>

This patch series applies on top of

    mh/fetch-tags-in-addition-to-normal-refs

and has some minor conflicts with that branch (mostly related to
documentation).

Let me state in advance that I personally think that the features
implemented in this patch series are overkill.  But since it was
already implemented, I thought I would throw it out there and see if
anybody likes it.

This patch series makes it possible for the user to specify explicitly
which reference namespaces should be subjected to pruning when
fetching from a remote.

* It allows a <pattern> to be passed to the --prune option for the
  following commands:

      git fetch --prune=<pattern> [...]
      git remote update --prune=<pattern> [...]
      git remote prune --prune=<pattern> [...]

          Only references that match the specified pattern(s) are
          considered for pruning.

      git remote show --prune=<pattern> [...]

          Only show prunable references that match the specified
          pattern(s).

  The --prune=<pattern> option can be specified multiple times.

* It introduces the following multivalued configuration values:

      fetch.pruneRef
      remote.<name>.pruneRef

          Configuration settings for setting the default
          "--prune=<pattern>" options, globally and per-remote.

Background: I started working on this feature as my first approach to
solving the problem that

    git fetch --tags --prune

can nuke tags unrelated to the remote being fetched from.  Only later
did I hit upon the better solution that is implemented in
mh/fetch-tags-in-addition-to-normal-refs, namely to change the
semantics of the --tags option to *not* subject tags to pruning.

But even though "--prune=<pattern>" is no longer needed to prevent tag
nuking, it might be useful to somebody for other purposes, and
therefore I am submitting it to the list as an RFC.  Maybe there is a
use case associated with non-branch, non-tag references, like perhaps
Gerrit pull request-related references?

Personally, I am -0 on this series.  I think it adds more complication
(code, documentation, etc) than its usefulness justifies.  I think the
functionality in mh/fetch-tags-in-addition-to-normal-refs (which we
want in any case!) will satisfy 99% of users and I can't think of use
cases where additional configurability of reference pruning is needed.

So, if anybody can think of a compelling use case for this feature,
please make your case!

Michael

Michael Haggerty (11):
  get_stale_heads(): allow limiting to refname patterns
  remote.c: add infrastructure for parsing --prune options
  fetch: use the new functions for handling --prune options
  remote: use the new functions for handling --prune options
  remote.c: add infrastructure to handle --prune=<pattern>
  fetch --prune: allow refname patterns to be specified
  remote update --prune: allow refname patterns to be specified
  string_list_append_list(): new function
  remote prune: allow --prune=<pattern> options
  remote show: allow --prune=<pattern> options
  remote: allow prune patterns to be configured

 Documentation/config.txt                    |  28 ++++--
 Documentation/fetch-options.txt             |  13 ++-
 Documentation/git-remote.txt                |  29 +++++--
 Documentation/technical/api-string-list.txt |  10 ++-
 builtin/fetch.c                             |  43 +++------
 builtin/remote.c                            |  85 ++++++++++++------
 remote.c                                    | 130 +++++++++++++++++++++++++++-
 remote.h                                    |  48 +++++++++-
 string-list.c                               |   9 ++
 string-list.h                               |   8 ++
 t/t5505-remote.sh                           |  88 +++++++++++++++++++
 t/t5510-fetch.sh                            |  25 ++++++
 12 files changed, 441 insertions(+), 75 deletions(-)

-- 
1.8.4.3
