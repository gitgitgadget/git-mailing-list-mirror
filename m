From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 18/26] refs: move transaction functions into common
 code
Date: Sun, 01 Nov 2015 09:17:14 +0100
Message-ID: <5635CA8A.2080505@alum.mit.edu>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com> <1445998467-11511-19-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 09:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsnwX-0005dM-OK
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 09:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbbKAIYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 03:24:19 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53814 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbbKAIYS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 03:24:18 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2015 03:24:18 EST
X-AuditID: 12074414-f794f6d000007852-69-5635ca8cbf24
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 40.28.30802.C8AC5365; Sun,  1 Nov 2015 03:17:16 -0500 (EST)
Received: from [192.168.69.130] (p5DDB24F4.dip0.t-ipconnect.de [93.219.36.244])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA18HEH3014283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 1 Nov 2015 03:17:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1445998467-11511-19-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqNtzyjTM4O4JPYv5m04wWnRd6Way
	aOi9wuzA7HHxkrLHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M44/H0/Y8F/jorm/n8sDYwt
	7F2MnBwSAiYSZ9fuYYOwxSQu3FsPZHNxCAlcZpQ4uuIAO4Rzjkli5fRpYFW8AtoSHc0nWUBs
	FgFVievHf7CC2GwCuhKLepqZQGxRgSCJFctfMELUC0qcnPkErF5EwEHi8q6jzCA2s4CaxKEl
	j4BqODiEBQIllq2zgNjVxihx6fwfsDmcAl4SX9evZYSo15PYcf0XK4QtL9G8dTbzBEaBWUhW
	zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIcErsoPxyEm5
	Q4wCHIxKPLwvvpqECbEmlhVX5h5ilORgUhLlZf4JFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	e2W9aZgQb0piZVVqUT5MSpqDRUmc99tidT8hgfTEktTs1NSC1CKYrAwHh5IEb8ZJoEbBotT0
	1Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7T33QmQvcUFiblAUYjWU4yK
	UuK8gSBzBUASGaV5cGNhKekVozjQl8K8FseBqniA6Qyu+xXQYCagweHbwAaXJCKkpBoYCwy8
	677V/J0h3jiFh9cugP9v+EI3+5kPbqyWyfZkL9DeqXDWbJPnBh3FsI9+H5dtM76tVjNZ/lei
	6Ie9DzVb5/bZ/wh63/Lebm9T7J641Wei3z3r3pjkFykgyKjgyzZV3T9G4btI5hKT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280612>

On 10/28/2015 03:14 AM, David Turner wrote:
> The common ref code will build up a ref transaction.  Backends will
> then commit it.  So the transaction creation and update functions should
> be in the common code.  We also need to move the ref structs into
> the common code so that alternate backends can access them.
> 
> Later, we will modify struct ref_update to support alternate backends.

I would prefer that this and later patches *not* add declarations to the
public API in refs.h for functions and data that are only meant to be
used by other reference backends.

So I'm working on a modified version of your series that declares such
functions in refs-internal.h [1] instead. I hope to submit it tomorrow.

Actually, I have half a mind to move all of the refs-related files to a
subdirectory, like

    refs.h
    refs/refs.c
    refs/refs-internal.h
    refs/refs-be-files.c
    refs/refs-be-lmdb.c       <- still to come

What would you think of that?

Michael

[1] We've discussed this idea earlier, using the tentative names
refs-shared.h or refs-common.h.

-- 
Michael Haggerty
mhagger@alum.mit.edu
