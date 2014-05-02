From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Zsh submodule name completion borked
Date: Fri, 2 May 2014 12:23:02 -0400
Message-ID: <CABURp0qdd6LYVfF0g8BWo_xjK36LbS=EnXkF_Kb4XQPM8U9r_g@mail.gmail.com>
References: <CABURp0oS0qnyVhfV1rsaNXT-88QJvgpNn+meApNKRTGdULDXpA@mail.gmail.com>
 <5362cc42ed06d_569a13852ecb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 18:23:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgGFK-0002Aq-8b
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 18:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbaEBQXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 12:23:25 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:47995 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbaEBQXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 12:23:24 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so202264wgh.12
        for <git@vger.kernel.org>; Fri, 02 May 2014 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n9GOJogKmklfejnlH9dztmLxmrrDdSBvw40iylCzmCs=;
        b=Y6EGgqbYas4+7qTNK0HtyhEy0FZjDYVchxOtPxjdtsxw/EtG6iHOzii7CGodqxvFDl
         T2OaiBU0j4TeGXTC9fN4Ul0/A60Tfjo/+MOq0Xbn822OPcc+ZyI5eWmml9LtRA3bWHPt
         Eht+rnUg2JN+TiUlvrNxReWPYD8/W5wV/GPhN+ju6vWqepXqBDbcTpEH7T0huTbKf5Su
         001wemZ/SMeGrhZFbOnLduXYCo1bxm7UodTNYm2upBLac8m5tvWGF84qiri9VackeU6k
         d2tvqp+KBuqZpEGOBD4ZZ3cXRNBcYwKkrA78Vtyfr3WGckECe4GxsrtQcgOCIqr5RZ6j
         W0QQ==
X-Received: by 10.194.60.114 with SMTP id g18mr2514169wjr.61.1399047802611;
 Fri, 02 May 2014 09:23:22 -0700 (PDT)
Received: by 10.227.231.193 with HTTP; Fri, 2 May 2014 09:23:02 -0700 (PDT)
In-Reply-To: <5362cc42ed06d_569a13852ecb@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247942>

On Thu, May 1, 2014 at 6:35 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Phil Hord wrote:
>> When I use zsh tab-completion to complete the submodule name in 'git
>> submodule init', I get more than I expected.
>>
>> From the gerrit repository (which has plugins):
>>   $ git submodule init plugins/<TAB>
>>   plugins/commit-message-length-validator\ \(v1.0-rc1-9-g545000b\)
>>   plugins/reviewnotes\ \(v1.0-rc1-8-ge984300\)
>>   plugins/replication\ \(v1.1-rc0-13-g4c3f4c9\)
>>
>> It works ok in bash.  I tried to bisect the trouble, but it still
>> fails in 1.8.3, so I'm beginning to think it's me.  Does this happen
>> to anyone else?  Is it something in my local configuration causing
>> this?
>

It seems to be something local.  I thought the issue persisted with no
local .zshrc config, but it looks like I only turned off my local
config and not the global settings.  The recent Ubuntu update is a
likely culprit.  I'll investigate locally and turn my reports up to
Ubuntu/Debian/Zshell.

> Define 'works' in bash. From what I can see from the bash completion,
> it's not doing anything special, so the completion you see are simply
> files.

To clarify my description in case anyone else sees it or is
interested, before I load /etc/zsh/zshrc, tab gives me simple filename
expansion.

After I load /etc/zsh/zshrc, tab expands only submodules in HEAD.  But
for some reason it gets the wrong kind of results in the expansion,
returning not just submodule paths, but submodule paths with tag info
appended.

Sample session:
  $ zsh --norcs
  % git submodule init plugins/<TAB>
   commit-message-length-validator/
   README
   reviewnotes/
   replication/
  ^C
  % source /etc/zsh/zshrc
  % git submodule init plugins/<TAB>
  plugins/commit-message-length-validator\ \(v1.0-rc1-9-g545000b\)
  plugins/reviewnotes\ \(v1.0-rc1-8-ge984300\)
  plugins/replication\ \(v1.1-rc0-13-g4c3f4c9\)
