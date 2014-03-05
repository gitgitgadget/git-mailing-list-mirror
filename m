From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/6] cache_tree_find() workover
Date: Wed,  5 Mar 2014 18:26:24 +0100
Message-ID: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:33:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFhR-0005g1-OM
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbaCERdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:33:42 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52513 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204AbaCERdl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:33:41 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2014 12:33:41 EST
X-AuditID: 12074412-f79d46d000002e58-36-53175e4eb22d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.2B.11864.E4E57135; Wed,  5 Mar 2014 12:26:38 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY79022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:36 -0500
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqOsXJx5ssOGdkcXsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfGo2nfWAoO
	cFTsWdPG2sD4kq2LkZNDQsBEYuvSVlYIW0ziwr31QHEuDiGBy4wS+yYeZIZwjjJJfDk0nxmk
	ik1AV2JRTzMTiC0ioCYxse0QC4jNLJAm8WDLFTBbWMBIYnLDIXYQm0VAVWLCxslA9RwcvALO
	EnMnMUMsk5OY8nsB+wRG7gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcx
	QoJBaAfj+pNyhxgFOBiVeHg3+IkHC7EmlhVX5h5ilORgUhLlvRoNFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCGxAJlONNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuBV
	iAVqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAcFenwxMNRBUjxAe0VA2nmLCxJz
	gaIQracYFaXEeRVBEgIgiYzSPLixsBh/xSgO9KUwRBUPMD3Adb8CGswENDiaD2xwSSJCSqoB
	6CPtLX/c2KOi12+J/271JsYhKm5mWJDMtws7SwP2py3rs9/8wLo58b8n+6lbZklmMa/FNj39
	ZWz49zdT3g4+lykW///zJxVenHhgSr+kt8enqSdalJ4t7vZkXfZJTeJQ549s01fTH76UKdDx
	5tyXpJdxwE3qk9TLy7lXdk++vEf8ybcrvNEiSizFGYmGWsxFxYkAdizXfswCAAA= 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243451>

Who would have expected so much slop in one little function?  Here are
the changes coming out of a long email thread.

I feel a little bit silly submitting six separate patches, but they
really are independent.  And two of the changes were suggested by
other people, so splitting those out, at least, helps give credit
where it is due.  But feel free to squash the patches together if you
think it is best.

Changes since v2 (aside from the atomization):

* Use strchrnul() to initialize slash (as suggested by Junio)

* Don't initialize variable at declaration (as per Junio's
  preference).

Thanks to Junio and David for this workout.

Michael Haggerty (6):
  cache_tree_find(): remove redundant checks
  cache_tree_find(): initialize slash using strchrnul()
  cache_tree_find(): fix comment formatting
  cache_tree_find(): remove redundant check
  cache_tree_find(): remove early return
  cache_tree_find(): use path variable when passing over slashes

 cache-tree.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
1.9.0
