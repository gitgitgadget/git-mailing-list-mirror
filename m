From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 15:20:30 +0100
Message-ID: <adf1fd3d0811030620x1bc53db3y2afb26242e9906ac@mail.gmail.com>
References: <200811031439.12111.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_57082_22639935.1225722030177"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Foster" <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 15:22:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx0JP-0000uJ-9F
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 15:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbYKCOUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 09:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbYKCOUd
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 09:20:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:32702 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbYKCOUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 09:20:32 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1722283ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 06:20:30 -0800 (PST)
Received: by 10.103.168.5 with SMTP id v5mr83619muo.35.1225722030184;
        Mon, 03 Nov 2008 06:20:30 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Mon, 3 Nov 2008 06:20:30 -0800 (PST)
In-Reply-To: <200811031439.12111.brian.foster@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99946>

------=_Part_57082_22639935.1225722030177
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Nov 3, 2008 at 2:39 PM, Brian Foster
<brian.foster@innova-card.com> wrote:
>
> Hello,
>
>  A colleague and I recently wanted to examine the
>  history in a broad sense without worrying too much
>  about the individual commits.  What we (think we)
>  wanted is a 'gitk --all' history graph showing only
>  "named" historical points; i.e., tags and branch
>  HEADs, perhaps with an indication of whether or not
>  it's a "linear" change sequence that leads from one
>  to another.  That is, hypothetically, if the history
>  looks something like (where 'A' &tc has a name as
>  per above, and '*' does not):
>
>     A--->*--->*--->C--->D--->*----->E
>      \                   \         /
>       \->*-->B            \->*--->*--->F
>
>  What we wanted to see is something like:
>
>     A------>C--->D--->E
>      \       \       /
>       \->B    \-----/--->F
>
>  Is there some way of doing something similar to that
>  (git v1.6.0.2)?  In addition to 'gitk', we also (rather
>  quickly!) tried both 'qgit' and 'giggle', but without
>  any apparent success.

Not in git.git but you can use the script at the bottom (also attached
in case it is whitespace damage).
It could be much faster if "git log" stops when finding a tag/branch.

HTH,
Santi

[git-overview]
#!/bin/sh

TMP=$(mktemp -t git-overview.XXXXXXXXXXX)
trap 'rm -f "$TMP"' 0 1 2 3 15

git log --reverse --pretty=short --decorate --pretty=format:%H%d $@ |\
    awk 'BEGIN {FS="[ ,()]*"} NF>=2 {print $1}' | \
    while read hash ; do
    # Independent tags/branches parents:
    # Notes:
    #   * -n 1000 to limit the search, ideally "git log" could stop
    #     traversing the history when hits a tag/branch tip
    #   * head -n 25 because "git show-branch --independent" has this limit
    ancestors=$(git log -n 1000 --pretty=short --decorate
--pretty=format:%H%d $hash^@ |\
    awk 'BEGIN {FS="[ ,()]*"} NF>=2 {print $1}' | head -n 25)
    if [ -n "$ancestors" ] ; then
	echo $hash $(git show-branch --independent $ancestors)
    else
	echo $hash
    fi
done > $TMP
GIT_GRAFT_FILE=$TMP gitk "$@" -d

------=_Part_57082_22639935.1225722030177
Content-Type: application/octet-stream; name=git-overview
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn377eps0
Content-Disposition: attachment; filename=git-overview

IyEvYmluL3NoCgpUTVA9JChta3RlbXAgLXQgZ2l0LW92ZXJ2aWV3LlhYWFhYWFhYWFhYKQp0cmFw
ICdybSAtZiAiJFRNUCInIDAgMSAyIDMgMTUKCmdpdCBsb2cgLS1yZXZlcnNlIC0tcHJldHR5PXNo
b3J0IC0tZGVjb3JhdGUgLS1wcmV0dHk9Zm9ybWF0OiVIJWQgJEAgfFwKICAgIGF3ayAnQkVHSU4g
e0ZTPSJbICwoKV0qIn0gTkY+PTIge3ByaW50ICQxfScgfCBcCiAgICB3aGlsZSByZWFkIGhhc2gg
OyBkbwogICAgIyBJbmRlcGVuZGVudCB0YWdzL2JyYW5jaGVzIHBhcmVudHM6CiAgICAjIE5vdGVz
OgogICAgIyAgICogLW4gMTAwMCB0byBsaW1pdCB0aGUgc2VhcmNoLCBpZGVhbGx5ICJnaXQgbG9n
IiBjb3VsZCBzdG9wCiAgICAjICAgICB0cmF2ZXJzaW5nIHRoZSBoaXN0b3J5IHdoZW4gaGl0cyBh
IHRhZy9icmFuY2ggdGlwCiAgICAjICAgKiBoZWFkIC1uIDI1IGJlY2F1c2UgImdpdCBzaG93LWJy
YW5jaCAtLWluZGVwZW5kZW50IiBoYXMgdGhpcyBsaW1pdAogICAgYW5jZXN0b3JzPSQoZ2l0IGxv
ZyAtbiAxMDAwIC0tcHJldHR5PXNob3J0IC0tZGVjb3JhdGUgLS1wcmV0dHk9Zm9ybWF0OiVIJWQg
JGhhc2heQCB8XAogICAgYXdrICdCRUdJTiB7RlM9IlsgLCgpXSoifSBORj49MiB7cHJpbnQgJDF9
JyB8IGhlYWQgLW4gMjUpCiAgICBpZiBbIC1uICIkYW5jZXN0b3JzIiBdIDsgdGhlbgoJZWNobyAk
aGFzaCAkKGdpdCBzaG93LWJyYW5jaCAtLWluZGVwZW5kZW50ICRhbmNlc3RvcnMpCiAgICBlbHNl
CgllY2hvICRoYXNoCiAgICBmaQpkb25lID4gJFRNUApHSVRfR1JBRlRfRklMRT0kVE1QIGdpdGsg
IiRAIiAtZAo=
------=_Part_57082_22639935.1225722030177--
