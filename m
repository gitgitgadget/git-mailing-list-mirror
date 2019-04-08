Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262E320248
	for <e@80x24.org>; Mon,  8 Apr 2019 13:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDHNVU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 8 Apr 2019 09:21:20 -0400
Received: from mx1.silicon-gears.com ([81.47.169.96]:38384 "EHLO
        mx1.silicon-gears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHNVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 09:21:19 -0400
X-Greylist: delayed 1580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 09:21:19 EDT
From:   Ismael Luceno Cortes <ismael.luceno@silicon-gears.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ismael Luceno Cortes <ismael.luceno@silicon-gears.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
Subject: [PATCH v3] git-gui: Handle Ctrl + BS/Del in the commit msg
Thread-Topic: [PATCH v3] git-gui: Handle Ctrl + BS/Del in the commit msg
Thread-Index: AQHU7gpDhunK4pRPI0qI99fjQdL07Q==
Date:   Mon, 8 Apr 2019 12:54:54 +0000
Message-ID: <20190408125406.16703-1-ismael.luceno@silicon-gears.com>
Accept-Language: en-GB, es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-User-Approved-Sender: Yes;No
X-TMASE-Result: 10--3.702900-10.000000
X-TMASE-MatchedRID: yHMs+sHflux0lqR8D0fH0d/wYmMFcJSIYYoLZVjtlFtSWdeg/8Oe81dm
        op201HzEG+Su3vFkPgokOZlozX424EYZ9RhNc4Kmz5r5y9mouSAk227IvqakhcAtnXPNjFICkb+
        qhi+AKmf2vjmPQvPnDj7mUl9qbYX6b3gilrWi3GjDg+U1NSmcuSqQalMhs4UBXCmcAC8DBrMpY9
        74Ts/ZMeLzNWBegCW2wguWqZ8eM0oLbigRnpKlKZx+7GyJjhAU5xJuB3oSRMsVscYZqITqEe9lO
        dRPxKWVUyvM97SZeVkMJnqMmx6lQ9AK73tscIFja1rCQb1ilOlveYZo3Zhiy+IhJf1KrZEyG/jZ
        66588BoGV1/AyO9F1RcFbU5/D4/qqlHKWhDz7PzFhXMjdQIJpg==
X-IMSS-DKIM-White-List: No;No
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Control+BackSpace: Delete word to the left of the cursor.
- Control+Delete   : Delete word to the right of the cursor.

Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
they were adopted by most CUA-Compliant UIs, including those of: OS/2,
Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.

In both cases Tk already implements the functionality bound to other key
combination, so we use that.

Graphical examples:

Deleting to the left:
        v------ pointer
X_WORD____X
  ^-----^------ selection

Deleting to the right:
  v--------- pointer
X_WORD_X
  ^--^------ selection

Signed-off-by: Ismael Luceno <ismael.luceno@silicon-gears.com>

---

CC: Junio C Hamano <gitster@pobox.com>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: Pat Thoyts <patthoyts@users.sourceforge.net>

Notes:
    Changes since v2:
    - Reimplemented via existing events, which correctly delete spaces.
    - Further improved commit message.
    
    Changes since v1:
    - Improved commit message.

 git-gui/git-gui.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 6de74ce639..c4e0270626 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3812,6 +3812,8 @@ bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_context;break}
 bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
 bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
 bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
+bind $ui_comm <Control-Key-BackSpace> {event generate %W <Meta-Delete>;break}
+bind $ui_comm <Control-Key-Delete> {event generate %W <Meta-d>;break}
 
 bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
 bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
-- 
2.19.1
