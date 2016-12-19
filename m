Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564801FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbcLSQpZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:45:25 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61893 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933194AbcLSQpY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:24 -0500
X-AuditID: 12074411-fa3ff700000009b7-32-58580ea25847
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 64.97.02487.2AE08585; Mon, 19 Dec 2016 11:45:22 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKQr011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:21 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
Date:   Mon, 19 Dec 2016 17:44:59 +0100
Message-Id: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42IRYndR1F3EFxFhcP23jUXXlW4mi9sr5jNb
        rDmymN2B2ePv+w9MHnN39TF6fN4kF8AcxWWTkpqTWZZapG+XwJVxYM8xloJX4hUrZs9iamD8
        INTFyMEhIWAisWaaShcjF4eQwGVGiZYFvewQzikmiY0bJ7F0MXJysAnoSizqaWYCaRARUJVY
        f0EIJMws4CCx+XMjI4gtLOAl0fl7CZjNAlTyd/4/VhCbV8Bc4tCSBrC4hICcxKVtX5gnMHIt
        YGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRHiYcEdjDNOyh1iFOBgVOLh
        LXgfFiHEmlhWXJl7iFGSg0lJlHc/T0SEEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeb7xAOd6U
        xMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBO99kEbBotT01Iq0zJwShDQT
        ByfIcB6g4Q/AhhcXJOYWZ6ZD5E8xKkqJ8zqCJARAEhmleXC9sAh8xSgO9IowLycwHoV4gNEL
        1/0KaDAT0OCF3eEgg0sSEVJSDYwzYyczpXbPLI4sUgw1OCPd63fG5Y5F8cY1cf33pt7lP6M1
        0Xnxp/z5CkKVd2Tiraafk9aS6vR9amHz3cHD+a9ku9ZMTouTLc+CO2ZUVPCWh19+P7nqPheH
        7CzLM4YHNhXuvr5YxsLEN+WW96Nt7+bfmGTZYKWnsDjLW99m81ShM98mpl+z0lFiKc5INNRi
        LipOBADj+AqEmwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series changes a bunch of details about how remote-tracking
references are rendered in the commit list of gitk:

* Omit the "remote/" prefix on normal remote-tracking references. They
  are already distinguished via their two-tone rendering and (usually)
  longer names, and this change saves a lot of visual clutter and
  horizontal space.

* Render remote-tracking references that have more than the usual
  three slashes like

      origin/foo/bar
      ^^^^^^^

  rather than

      origin/foo/bar (formerly remotes/origin/foo/bar)
      ^^^^^^^^^^^              ^^^^^^^^^^^^^^^^^^^

  , where the indicated part is the prefix that is rendered in a
  different color. Usually, such a reference represents a remote
  branch that contains a slash in its name, so the new split more
  accurately portrays the separation between remote name and remote
  branch name.

* Introduce a separate constant to specify the background color used
  for the branch name part of remote-tracking references, to allow it
  to differ from the color used for local branches (which by default
  is bright green).

* Change the default background colors for remote-tracking branches to
  light brown and brown (formerly they were pale orange and bright
  green).

I understand that the colors of pixels on computer screens is an even
more emotional topic that that of bikesheds, so I implemented the last
change as a separate commit, the last one in the series. Feel free to
drop it if you don't want the default color change.

Along the way, I did a bunch of refactoring in the area to make these
changes easier, and introduced a constant for the background color of
"other" references so that it can also be adjusted by users.

(Unfortunately, these colors can only be adjusted by editing the
configuration file. Someday it would be nice to allow them to be
configured via the preferences dialog.)

It's been a while since I've written any Tcl code, so I apologize in
advance for any howlers :-)

This branch applies against the `master` branch in
git://ozlabs.org/~paulus/gitk.

Michael

Michael Haggerty (13):
  gitk: when processing tag labels, don't use `marks` as scratch space
  gitk: keep track of tag types in a separate `types` array
  gitk: use a type "tags" to indicate abbreviated tags
  gitk: use a type "mainhead" to indicate the main HEAD branch
  gitk: fill in `wvals` as the tags are first processed
  gitk: simplify regexp
  gitk: extract a method `remotereftext`
  gitk: only change the color of the "remote" part of remote refs
  gitk: shorten labels displayed for modern remote-tracking refs
  gitk: use type "remote" for remote-tracking references
  gitk: introduce a constant otherrefbgcolor
  gitk: add a configuration setting `remoterefbgcolor`
  gitk: change the default colors for remote-tracking references

 gitk | 114 ++++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 76 insertions(+), 38 deletions(-)

-- 
2.9.3

