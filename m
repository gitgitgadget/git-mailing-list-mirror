From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Take only numeric version components when
 computing $git_version
Date: Thu, 13 Jan 2011 13:22:43 -0600
Message-ID: <20110113192243.GA20625@burratino>
References: <4D231646.5080005@debugon.org>
 <1294360953.21006.2.camel@fixed-disk>
 <4D2C5F3E.2020007@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Thu Jan 13 20:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdSlN-0003vD-DS
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 20:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab1AMTXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 14:23:07 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46680 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab1AMTXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 14:23:05 -0500
Received: by ewy5 with SMTP id 5so1096341ewy.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UP8Ny56MPV3bqJ8ZnLx/RCO9rgC0OzkAokh1nXQjrWQ=;
        b=m+7UthG4i9An/0k1We1g7rlKFxaxdFkOvpE2cPuxdettVTlZaDPi1ry4aYlPrId1co
         BKRUFCTBYkrqlINvF60T3jgnDTu53KrYqvSZNv8bFyjq7IR9ugC3Ki9hUcopyrH9jPWX
         3eO+kq0jnrFD9v89o29v4DiNftLZDgsjWuaCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Y3/4YtEGvZBLzyDyfYenwPnPhBJa2EnS7JBhIhxz0FyjE29Em/ZkItDyfvB46ytOsj
         GQi0T21+f8a2QK/gw1xz9+jePZbyJJ9lOPukwey+iHCcGNYzkbT5GaisAs1y6GLtCrCW
         Rh5+aHARUnqHHziUDxw26wc4qQHdRUixr9fiY=
Received: by 10.103.219.14 with SMTP id w14mr387633muq.3.1294946584122;
        Thu, 13 Jan 2011 11:23:04 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id l3sm160503fan.0.2011.01.13.11.23.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Jan 2011 11:23:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2C5F3E.2020007@debugon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165064>

Mathias Lafeldt wrote:
> Anders Kaseorg wrote:

>> This fixes errors running with release candidate versions of Git:
>>   Error in startup script: expected version number but got "1.7.4-rc0"
[...]
> People don't seem to use gitk with the RC releases because nobody else
> complains...

GIT-VERSION-GEN contains:

	DEF_VER=v1.7.4-rc1
	[...]
	if test -f version
	then
		[...]
	elif test -d .git -o -f .git &&
		[...]
	then
		VN=$(echo "$VN" | sed -e 's/-/./g');
	else
		VN="$DEF_VER"
	fi

So after building from a tarball generated with "git archive", "git version"
produces v1.7.4-rc1, producing errors from gitk, but after building
from the git repo or a tarball generated with "make dist", the version
is v1.7.4.rc1 (which gitk accepts).

Anders's fix looks good to me for robustness reasons anyway, so

 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Maybe the substitution in GIT-VERSION-GEN should say something like

		VN=$(echo "$VN" | sed -e 's/-\([^r]\)/.\1/g')

meaning the result for tagged rcs would not depend on whether git is
present?  Alternatively, DEF_VER could be set to v1.7.4.rc1, which
does not seem as nice to me.
