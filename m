From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 11:00:37 +0000
Message-ID: <200702191100.42953.andyparkins@gmail.com>
References: <200702190916.35813.andyparkins@gmail.com> <7vbqjq8ojr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 12:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ6Gq-0003mw-VR
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 12:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbXBSLAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 06:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbXBSLAu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 06:00:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:57967 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbXBSLAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 06:00:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2390943nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 03:00:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SrBzMiyJ8KlQBISjzUC6FUf86T6Zk46ikVm8f/LI8ZXOua471iIwbckyZ9YhCjkoa2Yq9O5rOOfefj5ivvipiebUOgm772sLe1GXUrHjlu8QCPC3MVz2OGiOCjMVubomZN3v2EqIo+49MvZXEYDgvK/SZWkw4AExWaYmTYsx6uA=
Received: by 10.48.202.11 with SMTP id z11mr5616968nff.1171882847615;
        Mon, 19 Feb 2007 03:00:47 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id r33sm26007274nfc.2007.02.19.03.00.44;
        Mon, 19 Feb 2007 03:00:45 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqjq8ojr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40118>

On Monday 2007 February 19 09:49, Junio C Hamano wrote:

> I do not want to risk discouraging public discussion on this
> topic, but I am not sure if this is really worth it.

It's not primarily for that purpose, but rather to improve readability.

For example, this little bit of patch:

-       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[HASH_WIDTH_ASCII+5] != '\n')
                return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
-       buffer += 46;
+       buffer += HASH_WIDTH_ASCII+6;
        while (!memcmp(buffer, "parent ", 7)) {
-               if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+               if (get_sha1_hex(buffer+7, sha1) || buffer[HASH_WIDTH_ASCII+7] != '\n')
                        return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
-               buffer += 48;
+               buffer += HASH_WIDTH_ASCII+8;

Using HASH_WIDTH_ASCII+8 is much clearer for a reader to be able to understand
intent than 48.  Especially when the variables in question are called "buffer"
it's harder to track what is being stored in the buffer without a named constant.

There are also a few other places where 20 is used and HASH_WIDTH_ASCII is not
intended.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
