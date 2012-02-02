From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: I18N.pm is incompatible with perl < 5.8.3
Date: Thu, 2 Feb 2012 17:48:15 +0100
Message-ID: <CACBZZX5YuN8vpmTiP_38Aa=c3KDqEHCKBX3DE2YKkeMCdR4GBg@mail.gmail.com>
References: <4F2A8B78.6090902@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Thu Feb 02 17:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rszpy-000808-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 17:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab2BBQsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 11:48:38 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40733 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755397Ab2BBQsg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 11:48:36 -0500
Received: by lagu2 with SMTP id u2so1383643lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ylcwqIVdzQcjeK1IdCQ7fx8IUoh4aGGnV835JJL35jE=;
        b=rbUgTSkHkXPx/yud78Z/FbLbeib+VVNKF7UsURbPBQnjo5B0c6cPe9LvBEONIBR6DD
         50Czx3qUN36YpBguFNOC/JpNfIRss3UgiUDD5P9D6PqNfI8roorD/RMhDG0cR2D8FTfu
         1qCGcuNhLHzZ8uI3krdSzz3WPGMSLbvtxQak8=
Received: by 10.152.105.175 with SMTP id gn15mr1863427lab.23.1328201315231;
 Thu, 02 Feb 2012 08:48:35 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Thu, 2 Feb 2012 08:48:15 -0800 (PST)
In-Reply-To: <4F2A8B78.6090902@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189658>

On Thu, Feb 2, 2012 at 14:11, Tom G. Christensen
<tgc@statsbiblioteket.dk> wrote:
> Hello,
>

Thanks Tom, I'll submit a patch for that. Does this work, i.e. does
5.8.3 need *{import} = instead of *import = ?

    diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
    index 07597dc..5bcfed5 100644
    --- a/perl/Git/I18N.pm
    +++ b/perl/Git/I18N.pm
    @@ -2,7 +2,16 @@ package Git::I18N;
     use 5.008;
     use strict;
     use warnings;
    -use Exporter 'import';
    +BEGIN {
    +       require Exporter;
    +       if ($] < 5.008003) {
    +               *import = \&Exporter::import;
    +       } else {
    +               # Exporter 5.57 supporting this invocation was released with
    +               # 5.8.3
    +               Exporter->import('import');
    +       }
    +}

     our @EXPORT = qw(__);
     our @EXPORT_OK = @EXPORT;

But actually it might be better to check $Exporter::VERSION
