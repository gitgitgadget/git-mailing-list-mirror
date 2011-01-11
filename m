From: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
Subject: [BUG] difference of info from diff and blame
Date: Tue, 11 Jan 2011 13:38:50 +0300
Message-ID: <4D2C333A.3010401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 11:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcbdl-0004BW-QI
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 11:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab1AKKjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 05:39:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48751 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab1AKKjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 05:39:46 -0500
Received: by fxm20 with SMTP id 20so19781960fxm.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=rFyiuVKQSGVeiCdGO3egd+IsjLzJ6bdj87gRx6qv39s=;
        b=WuueKALc7Pq/dMSnY0imQg/p5PDWCqqnFeukiLZwtr6oQpuRBIt0SuJlmYW7xfPdFY
         Ezzc/pDf8mAMojMr+4SUjc8pb6PO3c1i9udH2U5MdKn4Ubk+gxsO0AyVBBDBPmvZ/TGJ
         vyMOBStetvUmYbbCw7tnMgKklDr7mZBr1bjjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=flt9t6ph0WvYXO91yvGpjKkFkFEElRW+GDEnS+oj2scDOC7nZaTphcFSVkDyavkbBO
         LAIsN68adO6QyWSlDgMT9f1EuIA0lhXqy72bLlsbhQaTBxyJefLXJHhSb3LppecqfJ3Q
         yNsO4nYEx49ueKIqMOout8aw3JYvrPzeSeIIs=
Received: by 10.223.73.206 with SMTP id r14mr1631545faj.126.1294742384807;
        Tue, 11 Jan 2011 02:39:44 -0800 (PST)
Received: from [46.147.19.174] ([46.147.19.174])
        by mx.google.com with ESMTPS id 21sm7317867fav.17.2011.01.11.02.39.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 02:39:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164926>

Hi.

I'm working on automatic processing of info from git. And I have some 
problems. Let me show it on an axample.

I have jquery repo (https://github.com/jquery/jquery.git)
Let's get blame for some file in some revision:
git blame -l -s 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6 -- 
src/event/event.js
According to blame, line 127 was added in revision 
2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6.
Let's get diff for that revision:
git diff-tree -p 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6 -- 
src/event/event.js
We can see this:
@@ -105,19 +120,16 @@ jQuery.event = {

  		// Handle triggering a single element
  		else {
-			var handler = element["on" + type ], val,
-				fn = jQuery.isFunction( element[ type
+			var val, ret, fn = jQuery.isFunction( element
+			
+			// Pass along a fake event
+			data.unshift( this.fix({ type: type, target:

-			if ( handler ) {

As you can see line 127 is not marked with '+' char, which means it was 
not added in this revision. But blame sad otherwise.

I had the same problem on a wide range of repos.
I think it's a bug.
