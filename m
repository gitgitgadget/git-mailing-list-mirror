From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] refs: mark the file-local vtable symbols as static
Date: Wed, 8 Jun 2016 15:48:02 +0100
Message-ID: <57583022.2030205@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAemN-000209-TA
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 16:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161912AbcFHOsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 10:48:10 -0400
Received: from avasout01.plus.net ([84.93.230.227]:54376 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423165AbcFHOsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 10:48:08 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 4Eo31t0075VX2mk01Eo4H2; Wed, 08 Jun 2016 15:48:05 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=ATcJsqxKh-rR1a4XqdMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296801>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Michael, Junio,

I would normally ask you to squash this into the relevant patch when
you next re-roll your 'mh/ref-iterators' branch, but this has already
been merged into next. (I normally have a bit more time ... sorry!).

Perhaps, after the release, when the next branch is re-wound/re-built,
this could be squashed into your branch then.

Anyway, after applying this patch, the following symbols are still
'public but unused':

	> refs/files-backend.o	- files_reflog_iterator_begin
	> refs/iterator.o	- is_empty_ref_iterator
	> refs/iterator.o	- merge_ref_iterator_begin

These all look (potentially) useful for the implementation of
additional 'ref-iter' types and look to be part of the _internal_
iterator API - so they should not be marked static. Can you just
confirm my interpretation.

Thanks.

ATB,
Ramsay Jones

 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a006a65..6213891 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -711,7 +711,7 @@ static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	return ITER_DONE;
 }
 
-struct ref_iterator_vtable cache_ref_iterator_vtable = {
+static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	cache_ref_iterator_advance,
 	cache_ref_iterator_peel,
 	cache_ref_iterator_abort
@@ -1933,7 +1933,7 @@ static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-struct ref_iterator_vtable files_ref_iterator_vtable = {
+static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	files_ref_iterator_advance,
 	files_ref_iterator_peel,
 	files_ref_iterator_abort
@@ -3354,7 +3354,7 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-struct ref_iterator_vtable files_reflog_iterator_vtable = {
+static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	files_reflog_iterator_advance,
 	files_reflog_iterator_peel,
 	files_reflog_iterator_abort
-- 
2.8.0
