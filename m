From: Steven Lawler <steven.lawler777@gmail.com>
Subject: [Bug] Query string not being phrased correctly when question marks
 present in config URL.
Date: Tue, 23 Sep 2014 04:20:55 +1000
Message-ID: <CAOf__z5DTzchZpnz-DzoOEHnt8RdypV7=RPP1=AzinsskQEg8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 20:21:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW8EQ-0004PO-7b
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 20:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbaIVSU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 14:20:58 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:39235 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbaIVSU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 14:20:57 -0400
Received: by mail-lb0-f172.google.com with SMTP id p9so6720056lbv.31
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6J8n7YKomNbNsMTHuPy5GYlGFxyYU7eh3nJ5ffBzIRI=;
        b=HGoBjuZRiXup0X1Teu17jmCELI9iSz3vGKBqZm1pYSOM4Tnve9bElza2HAJF80nmyi
         43gBdGMDXFSP4o/7ZMwpPC9Pa0r9eP01vjzSvHoPi5KGGzBpDR6RZwo2IXr1vDpxu6Ce
         +MZ+Ag/sp4cIxbR5KnHBWOVTJqnAsDrPQr/iP49UtUGyNgk0/sYybp1tIBlMMREWvSyB
         oRVxqmFBQUIaY4S65H5le3i1TdY+ulZ6eSyGWkeTyYEBu7CbowefXa25/MYEKqyGv8x9
         cxiQGrWl5R3Wty4EQ9zlvqK5BTOR0ZdWBDvLm2MeX8hWYti9A/RTUG+P2h+Ah4sF76gx
         IK0A==
X-Received: by 10.152.18.130 with SMTP id w2mr4413902lad.89.1411410055838;
 Mon, 22 Sep 2014 11:20:55 -0700 (PDT)
Received: by 10.25.90.17 with HTTP; Mon, 22 Sep 2014 11:20:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257374>

Cause:
[remote "repo"]
  url = http://example.com/git/example.com?foo=bar
There is a question mark in the URL of the repo URL.

Effect (Taken from Apache logs):
[22/Sep/2014:14:12:07 -0400] "GET
/git/example.com?foo=bar/info/refs&service=git-receive-pack HTTP/1.1"
403 207 "-" "git/1.9.4.msysgit.1"

Git attempts to correct the issue by making the query string continue
using ampersands where it would have started the original query
string.

Expected outcome:
The git client should move the ?foo=bar onto the beginning (or end) of
the query string that it is creating. For example:
[22/Sep/2014:14:12:07 -0400] "GET
/git/example.com/info/refs?foo=bar&service=git-receive-pack HTTP/1.1"
403 207 "-" "git/1.9.4.msysgit.1"

This is caused on the git client, double checked with Wireshark. I
have not tested this on HTTPS, but imagine the output is the same.
