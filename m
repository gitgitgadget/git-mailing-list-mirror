From: Tay Ray Chuan <rctay89@gmail.com>
Subject: coding style: #ifdef blocks and real C blocks
Date: Sun, 1 Mar 2009 16:52:49 +0800
Message-ID: <be6fef0d0903010052t50551f3w74352b69afdee620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 09:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdhRJ-00040l-UO
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 09:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZCAIww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 03:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZCAIww
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 03:52:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:59889 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZCAIwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 03:52:51 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1823514rvb.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=mxxfnZL/ELmYdU17zJW+VzHmQqFal776gEK5tbpNQ+E=;
        b=UkZUWmuV83jKH2ASWQUn89CWWHr/XG8eVynLl/Rzi7gI+oihCCjfUwcQ+Rn7jQE4ku
         A9V0jyIsApYmFvddC5dUNSJkzjUZK0o/dnm9oIah2D+pj90bzMlCXfZBuEtvLkJDCi5M
         KTA0ISQl/9Sm9EdXAnAMV212UNlrWluDUH1B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EDnTM+nkqXd0x4XEd/6CP4SChDO/5qUTc+d0Mn0/u9Go0tzNsNLKcpWQHJlG0ZPQe4
         bBQwt7gR57AGM6RvF+EOLM0KQ2TDL8hnfr29wR+1xsQEbNkh28nTdXDFrdNs/a+augbQ
         QoMlMhVFwlbBpbBmy892/nvmMvT37VS6fv/xQ=
Received: by 10.114.88.1 with SMTP id l1mr2055885wab.97.1235897569203; Sun, 01 
	Mar 2009 00:52:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111828>

Hi,

I couldn't find any mention of #ifdef usage nor any example of how I'm
thinking of using #ifdef, so I'm posing this here.

Right now here's what I have on my local branch:

---
#ifdef USE_CURL_MULTI
	slot = get_active_multi_slot();
#else
	slot = get_active_slot();
#endif
	slot->callback_func = process_response;
	slot->callback_data = request;
	request->slot = slot;
---

I want to implement an option that's stored in the variable
"persistent_connection", which basically makes the code behave as if
USE_CURL_MULTI isn't defined. (This would make git open/close less
connections throughout the lifespan of its execution, which would
remove/minimize the number of credential prompting if authentication
is required, among other advantages.)

Here's what I thought of:

---
#ifdef USE_CURL_MULTI
	if (!persistent_connection)
		slot = get_active_multi_slot();
	else
		slot = get_active_slot();
#else
	slot = get_active_slot();
#endif
---

I thought of shortening this further to

---
#ifdef USE_CURL_MULTI
if (!persistent_connection)
	slot = get_active_multi_slot();
else
#else
	slot = get_active_slot();
#endif
	slot->callback_func = process_response;
	slot->callback_data = request;
	request->slot = slot;
---

What would you suggest?

-- 
Cheers,
Ray Chuan
