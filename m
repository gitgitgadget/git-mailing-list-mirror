From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in
 incremental blame
Date: Sun, 06 Dec 2009 17:04:20 -0800
Message-ID: <1260147860.1579.47.camel@swboyd-laptop>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
	 <200911250145.16472.jnareb@gmail.com> <4B0CAC2E.1060105@gmail.com>
	 <200911251536.08993.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 02:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHS1d-0000r8-Bp
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 02:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364AbZLGBER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 20:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758358AbZLGBER
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 20:04:17 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64145 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758347AbZLGBEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 20:04:16 -0500
Received: by pwj9 with SMTP id 9so605038pwj.21
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 17:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=o87PbZTOabo2y2BGMhxv3uIIavsdTDE5EGrwKSexeNc=;
        b=M5OFvJkUOYqyZ6BEegGIQPFcZEXAMt/xqbD6ir/MQdxx13phvl3rglfrJoOBUkDy3r
         RHg4avZg5XByUIPHN0S2PhgFNjPjBzwcN2P3MVA2zTH12SWJS8OLw899dAMrtc9bGmjN
         +3vaWnGWty355ZVkYKH75qMRbETnPZhwKtb2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HZudLJ8gPIHT973VWDUtO7zA82pgvp5Bpucw9n8MMpn6sUtKq0HkoG+mVWsXGFfHPx
         RtRAZSKGZypM7wnXuRoXyTNACRnTBYtzu7fww/OPhLP3uYarOQ04O/lu8aVcYJkWwASD
         W+SV7L2YB8xdjZXYgbxIBCB6tXpPyz1J6Tz0c=
Received: by 10.115.102.5 with SMTP id e5mr6107158wam.210.1260147863001;
        Sun, 06 Dec 2009 17:04:23 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 20sm4744802pzk.5.2009.12.06.17.04.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 17:04:21 -0800 (PST)
In-Reply-To: <200911251536.08993.jnareb@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134705>

On Wed, 2009-11-25 at 15:36 +0100, Jakub Narebski wrote:
> Well, the one time I was able to run debugger (F12, select 'Script', select
> 'gitweb.js') with error occurring and without IE hanging (for README file)
> it did show an error for the following line:
> 
>   if (xhr.readyState === 3 && xhr.status !== 200) {
> 
> When I checked 'xhr' object, it has "Unknown error" as contents of 
> xhr.statusText field and as contents of xhr.status (sic!), which should
> be a number: HTTP status code.
> 
> Unfortunately I had to take a break... and I was not able to reproduce this
> (without hanging web browser: "program not responding") since then...
> 

Ok. It's December and I've had some more time to look into this.
Initializing 'xhr' to null seems to get rid of the "Unknown error"
problem (see patch below).

The responsiveness on IE8 is pretty poor. I load the page and then after
some waiting (usually 20-30 seconds including IE becoming a "Not
Responding" program) the whole page will load. There is nothing
incremental about it. I'm trying to figure out why it's slow now.

--->8----

Subject: [PATCH] gitweb.js: workaround IE8 "Unknown error"

Internet Explorer 8 complains about an "Unknown error on line 782, char 2".
That line is a reference to xhr and the status code. By initializing xhr
to null this error goes away.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 gitweb/gitweb.js |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 2a25b7c..b936635 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -126,7 +126,7 @@ function createRequestObject() {
 /* ============================================================ */
 /* utility/helper functions (and variables) */

-var xhr;        // XMLHttpRequest object
+var xhr = null;        // XMLHttpRequest object
 var projectUrl; // partial query + separator ('?' or ';')

 // 'commits' is an associative map. It maps SHA1s to Commit objects.
-- 
1.6.6.rc1.39.g9a42
