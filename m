From: Christian Meder <chris@absolutegiganten.org>
Subject: First web interface and service API draft
Date: Fri, 22 Apr 2005 12:41:56 +0200
Message-ID: <1114166517.3233.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 22 12:38:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOvXg-0005ex-DZ
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 12:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVDVKmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 06:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVDVKmT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 06:42:19 -0400
Received: from shadow.prohost.de ([216.71.84.228]:15611 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261296AbVDVKmC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 06:42:02 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3MAg1t19459
	for <git@vger.kernel.org>; Fri, 22 Apr 2005 12:42:01 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

me again after a couple of hours of sleep ;-)

This probably gets a bit longer so if you are not interested in a web
service api or the web interface now is your chance to get off the
train.

I'm probably making a complete git of myself but that's not uncalled
for in this contxt ;-)

For those that are still with me let me start by iterating again that
I _do_ care for URIs as the primary API for web service
applications _and_ humans. I probably don't have to tell Linux people
anything about the importance to get the API right ;-)

As it's fairly early in the web service interface cycle I like to change
things around a little bit and starting to get the API straight.

The following considerations should be pretty implementation agnostic
and not specific to wit. The interface should be flexible enough to be
used as a kind of web command line.

-------
/<project>

Ok. The URI should start by stating the project name
e.g. /linux-2.6. This does bloat the URI slightly but I don't think
that we want to have one root namespace per git archive in the long
run. Additionally you can always put rewriting or redirecting rules at
the root level for additional convenience when there's an obvious
default project.

Should provide some meta data, stats, etc. if available.

-------
/<project>/blob/<blob-sha1>
/<project>/commit/<commit-sha1>

These are the easy ones: the web interface should be able to spit out
the plain text data of a blob and a commit at these URIs. Users would
be probably scripts and other downloads.
Open questions:
* Blob data should be probably binary ?
* Should it be commit or changeset ? Linus seems to have changed
nomenclature in the REAME
* If we serve the pristine commit objects we will put the email
addresses in plain sight. If we remove or change the email addresses
it's not the original commit object anymore. Thoughts ?

-------
/<project>/tree/<tree-sha1>

Tree objects are served in binary form. Primary audience are scripts,
etc. Human beings will probably get a heart attack when they
accidentally visit this URI.

-------
/<project>/blob/<blob-sha1>.html
/<project>/commit/<commit-sha1>.html
/<project>/tree/<tree-sha1>.html

A HTML version of blob, commit and tree fully linked aimed at human
beings.

-------
/<project>/tree/<tree-sha1>.tar.bz2
/<project>/tree/<tree-sha1>.tar.gz
/<project>/commit/<commit-sha1>.tar.bz2
/<project>/commit/<commit-sha1>.tar.gz

Tarballs of the specified commits or trees. Note that these can be
individual subtrees too.


-------
/<project>/tree/<tree-sha1>/diff/<ancestor-tree-sha1>

Unified plain text recursive diff of the given trees. I guess the
user could specify any two tree ids but the relevance of the results
would vary greatly ;-)
* Possibly a DOS issue
* does something like /<project>/tree/<tree-sha1>/diff/ make sense
producing a full diff from scratch ?  

-------
/<project>/tree/<tree-sha1>/diff/<ancestor-tree-sha1>/html

Non recursive HTML view of the objects which are contained in the diff
fully linked with the individual HTML views.

-------
/<project>/blob/<blob-sha1>/diff/<ancestor-sha1>

Unified plain text diff of the given blobs.
* again /<project>/blob/<blob-sha1>/diff/ sensible ?

-------
/<project>/blob/<blob-sha1>/diff/<ancestor-sha1>/html

HTML view (probably colorized) view of a single blob diff.

-------
/<project>/changelog/<time-spec>

HTML changelog for the given <time-spec>. I think valid values for
timespec should be number of days <nnn>d, number of entries <nnn> and
the keyword 'all'.

* perhaps additionally number of hours <nnn>h, number of months
  <nnn>m, number of years <nnn>y. Combinations shouldn't be allowed
* time ranges are probably overkill
* is a plain text version needed /<project>/changelog/<time-spec/plain?

-------
/<project>/changelog/<time-spec>/search/<regexp>

HTML changelog for the given <time-spec> filtered by the <regexp>.

* again plain version needed ?

------
/<project>/changelog/<time-spec>/search/author/<regexp>
/<project>/changelog/<time-spec>/search/committer/<regexp>
/<project>/changelog/<time-spec>/search/signedoffby/<regexp>

convenience wrappers for generic search restricted to these fields.

------

open questions:
* how to generate and publish additional merge information ?
* how to generate and publish tree and blob history information ? This
is probably expensive with git.
* how to represent branches ? should we code up the branches in the
project id like linux-2.6-mm or whatever ?


Comments ? Ideas ? Other feedback ?




				Christian
  
-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

