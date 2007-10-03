From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: merging .gitignore
Date: Wed, 3 Oct 2007 09:23:20 +0100
Message-ID: <200710030923.22767.andyparkins@gmail.com>
References: <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 10:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IczW2-00088V-Of
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 10:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbXJCIX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 04:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbXJCIX3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 04:23:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:48244 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbXJCIX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 04:23:28 -0400
Received: by ug-out-1314.google.com with SMTP id z38so76352ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=gNeLyPnAWpXWSYmJccRl2LRd5b+pg/KYj1lXSILjqps=;
        b=GhOAr0cAYYdtCx+KOR5mr6gAlb+vOb4NppO+yEpCAeIammpZb9X9Sf9XHTrUvzB7J6Zi2o9N21lsQBFs6Vb5HGmbVoAV8UyahB0fs7f9Vix9EgRcxue8yKwvbEI3r2Sk3JlRiq+C+6r0yczlRBxLTPTpcrxbBPCIRkrKUSvus88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RfylZIzPJqzGZWmBGBkrtD8uhuKhW1REu5f2OOjK3mRkc9ktegaPUQRV4p7CaHdaULORMhRp4fFo5gyStoCergWDrvObWtkw5omMDSxKDDmGgNBtNXZ/N2YvNO8uNdrr8hrXZCM7j4yeEsn1cWiaoZCEjr80+07bPkaNb93EVsE=
Received: by 10.66.221.17 with SMTP id t17mr172881ugg.1191399805602;
        Wed, 03 Oct 2007 01:23:25 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c24sm118303ika.2007.10.03.01.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Oct 2007 01:23:24 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20071002195148.GA14171@lapse.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59805>

On Tuesday 2007 October 02, martin f krafft wrote:

> Well, with gitignore I am ready to say that merges should be
> resolved in an additive way. Remember that I am talking about an
> intergration branch, and if feature branches A and B used to ignore
> .o files, and now B suddenly does not ignore them anymore, the only

Okay; *.o was obviously not a good example.  A more detailed one: how about a 
change like this to a makefile (excuse bastardised diff format)

diff Makefile
-include depends.make
+include depends.mak

diff .gitignore
-depends.make
+depends.mak

>   cat $gitignore_files | sort -u

Now, say there is another branch that makes exactly this change but 
chooses "depends.inc" as the filename.  Your "additive only" merge 
of .gitignore will not flag the conflict and will leave a .gitignore with

depends.mak
depends.inc

The makefile conflict will have been resolved one way or the other but the 
gitignore conflict will not.  While it's not a serious fault it is wrong, and 
no one was signalled that it was wrong.

I am still having difficult seeing why you want to hide conflicts 
in .gitignore.  It's just as possible to get and resolve conflicts in 
gitignore as in any other file.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
