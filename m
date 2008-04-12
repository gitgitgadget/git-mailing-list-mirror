From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Sat, 12 Apr 2008 10:56:54 +0800
Message-ID: <46dff0320804111956p4eb3d9d7o3b404e1d93de5da2@mail.gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
	 <7vzls0qcmw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 04:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkVwB-0006ZS-5p
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 04:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbYDLC44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 22:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbYDLC4z
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 22:56:55 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:14119 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbYDLC4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 22:56:55 -0400
Received: by an-out-0708.google.com with SMTP id d31so176261and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=13b1Du4sy9T4hn/uNiFR7gQHPklLtDnMEe2VJ94VK10=;
        b=D19P9gELUXNs/kaXbIs78Ko0taTwBC0Q4n788xae6NpjdrGpELvxZ8DAN4EhR/yDMwN0QitJodRVEECs5hqt8F8AtaR9MkchPh2YtjyA+uvmW7M9fJ9m15essl4muZRIr10wloOKUXtycb7hn9spU5zk9hJYZ+XEHj2pMvGpqj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PcFKV7F5ewuN+LkfUQwUF0CJy0kr7uB6eeqL6c3LO4dhnLgwoxbp4fxwbh0XfpGj0j2yWMf3y/wGztCGwFgLSxzRDFOo+NlkGe7+TiqBmM6LehIxP0Atac7BZyk8YT7jD6cMEcssW8Anpe919HI0YRue0eB6of4kIOOHg3QO7dE=
Received: by 10.100.214.19 with SMTP id m19mr6751412ang.50.1207969014449;
        Fri, 11 Apr 2008 19:56:54 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 19:56:54 -0700 (PDT)
In-Reply-To: <7vzls0qcmw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79322>

On Sat, Apr 12, 2008 at 5:56 AM, Junio C Hamano <junio@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > This behaviour change breaks t7400 which uses relative url './.subrepo'.
>  > However, this test originally doesn't mean to test relative url, so fix
>  > the url as '.subrepo'.
>
>  Hmmm.  Doesn't "foo" generally mean the same thing as "./foo" in the sense
>  both are relative to the current directory?

There is a little inconsistence in current logic

1. git submodule add ./foo will expand foo with remote.origin.url and
init an entry in .gitmodules as
"submodule.foo.url=$remoteoriginurl/foo"
2. git submodule update will not expand ./foo if  there is an entry
"submodule.foo.url=./foo"  in $GIT_DIR/config

I tend to add the url as is when "git submodule add", and then expand
the url when running "git submodule update". So this will result that
the second case expands './foo' as "$remoteoriginurl/foo" instead of
"foo"





-- 
Ping Yin
