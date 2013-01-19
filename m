From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sat, 19 Jan 2013 07:18:52 +0100
Message-ID: <50FA3ACC.6070909@alum.mit.edu>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 07:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwRm9-0002Ip-UZ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 07:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab3ASGS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 01:18:57 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:54841 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051Ab3ASGS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 01:18:56 -0500
X-AuditID: 1207440f-b7f276d0000008b2-f2-50fa3ad03112
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 69.04.02226.0DA3AF05; Sat, 19 Jan 2013 01:18:56 -0500 (EST)
Received: from [192.168.69.140] (p57A2524C.dip.t-dialin.net [87.162.82.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0J6Ira6011392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 19 Jan 2013 01:18:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <1358555826-11883-1-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqHvB6leAwacLHBZdV7qZLBp6rzBb
	3H+/jsli/qGJrA4sHpf7epk8Ll5S9vhzfg+rx+dNcgEsUdw2SYklZcGZ6Xn6dgncGW0PfjEW
	TFKt6JzRwN7A+Em2i5GTQ0LAROLusXmMELaYxIV769m6GLk4hAQuM0qcu3KHFcI5zSRx9dYT
	oAwHB6+AtsSNZ9wgDSwCqhLdZ06xgthsAroSi3qamUBsUYEwid7X58CG8goISpyc+YQFxBYR
	UJOY2HYIzGYWcJLY9u8bmC0sYCbx8O85ZhBbSMBR4s6jtewgNidQzfMtvUwQ9ToS7/oeMEPY
	8hLb385hnsAoMAvJillIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81
	pXQTIySc+Xcwdq2XOcQowMGoxMObsuBngBBrYllxZe4hRkkOJiVR3lsmvwKE+JLyUyozEosz
	4otKc1KLDzFKcDArifCGfAYq501JrKxKLcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2Cycpw
	cChJ8E6xBBoqWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rU+GJgrIKkeID2rgRp
	5y0uSMwFikK0nmI05tj/pP05I8f230BSiCUvPy9VSpw3BqRUAKQ0ozQPbhEskb1iFAf6W5i3
	FaSKB5gE4ea9AlrFBLRK5OJ3kFUliQgpqQbG/Drvzv9h/8o/pM2zm/Rq68tkc3vxM99ncdbv
	1i2TO24820fix99vu7PX8E1Z/p796XMv/so2hkd3jU9/uhL8PXGvzA2LTfvPTzOc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213957>

On 01/19/2013 01:37 AM, Junio C Hamano wrote:
> This is an early preview of reducing the network cost while talking
> with a repository with tons of refs, most of which are of use by
> very narrow audiences (e.g. refs under Gerrit's refs/changes/ are
> useful only for people who are interested in the changes under
> review).  As long as these narrow audiences have a way to learn the
> names of refs or objects pointed at by the refs out-of-band, it is
> not necessary to advertise these refs.
> 
> On the server end, you tell upload-pack that some refs do not have
> to be advertised with the uploadPack.hiderefs multi-valued
> configuration variable:
> 
> 	[uploadPack]
> 		hiderefs = refs/changes
> 
> The changes necessary on the client side to allow fetching objects
> at the tip of a ref in hidden hierarchies are much more involved and
> not part of this early preview, but the end user UI is expected to
> be like these:
> 
> 	$ git fetch $there refs/changes/72/41672/1
> 	$ git fetch $there 9598d59cdc098c5d9094d68024475e2430343182
> 
> That is, you ask for a refname as usual even though it is not part
> of ls-remote response, or you ask for the commit object that is at
> the tip of whatever hidden ref you are interested in.

Although I can understand the pain of slow network performance, somehow
this proposal gives me the feeling of being expeditious rather than elegant.

Could the problem be solved in some other way?  Maybe such references
could be stored in a second repository or in a separate namespace (in
the sense of gitnamespaces(7)) to prevent their creating overhead when
they are unneeded?

And *if* reference hiding makes sense, it seems to me that the client,
not the server, should be the one who decides which server references it
is interested in (though I understand that would require a protocol
change).  Otherwise the git repository *relies* on out-of-band channels
for its functionality.  If I understand correctly, a user would have *no
way* to discover, via git, what hidden references are contained in a
remote repository, or indeed even that the repo contains a hidden
namespace.  For example this would make it impossible to clean up
obsolete "hidden" references on a remote repository without the
supplementary information stored elsewhere.  And if anybody accidentally
creates a reference in a hidden namespace by hand, it will just sit
there undetectably, forever.

I assume (though I've never checked) that a server does not let a client
ask for a SHA1 that is not currently reachable from a server-side
reference, and I assume that that you are not proposing to change this
policy.  But allowing objects to be fetched from a hidden reference
opens up some "interesting" possibilities:

* A pusher could upload arbitrary content to a public git server under a
cryptic hidden reference name.  Most people would be completely unable
to see this content, unless given the SHA1 or the reference name by the
pusher.  Thus this mechanism could be used as a dark channel to exchange
arbitrary data relatively secretly.

* Somebody could push a trojan version of code to a hidden reference in
a project, then pass the SHA1 to a victim.  The victim might trust the
code because it comes from a known project website, even though the code
would be invisible to other project developers and thus impossible for
them to audit.  And even if they learned about the trojan's SHA1 they
would be unable to remove it from their repository because they have no
way to find out the name of the hidden reference!

Obviously these hacks would only be possible for a bad guy with push
privileges to a repository that has turned on hidden references, but I
think they are sobering nevertheless.

These worries would go away if reference hiding were configured on the
client rather than on the server.

A second point: currently, the output of "git show-ref -d" and "git
ls-remote ." are almost identical.  Under your proposal, I believe that
the hiderefs would only be omitted from the latter.  Would it be useful
to add an option to "git show-ref" to make it omit the "hiderefs" refs?
 And maybe another option to make it display *only* the hideref refs?

And in the bikeshedding department, I wonder if "hiderefs" is the best
name for the config setting.  "hiderefs", implies to me that the refs
are actively hidden and not available to the client in any way.  But in
fact they are just not advertised; they can be fetched normally.  Maybe
another name would be more suggestive of its true effect, for example
"quietrefs" or "noadvertiserefs".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
