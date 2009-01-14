From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 19:58:09 -0500
Message-ID: <76718490901131658l108852f2y9a25eb9133d6e96d@mail.gmail.com>
References: <loom.20090113T145019-951@post.gmane.org>
	 <loom.20090113T150220-345@post.gmane.org>
	 <496CD49D.1070201@drmicha.warpmail.net>
	 <loom.20090113T185918-397@post.gmane.org>
	 <20090113203922.GD30404@atjola.homenet>
	 <loom.20090113T204616-845@post.gmane.org>
	 <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
	 <loom.20090113T211437-12@post.gmane.org>
	 <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com>
	 <loom.20090113T213400-985@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Vladimir Pouzanov" <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMu6b-0006eN-Bc
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 01:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZANA6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 19:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZANA6M
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 19:58:12 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:29876 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbZANA6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 19:58:11 -0500
Received: by rv-out-0506.google.com with SMTP id k40so264198rvb.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2Z3caybaEbZ6tZrLGqoiXKI6Mcs1n+bLXe+0xUNqH5o=;
        b=RyDwxPMA7Iir1f6bYhbld4J567Y7MU/TJntcxGujceovcNeOjUcSJWlwU9wl8kh1e7
         qjVbSPwwAQcNCC7HyLbN4t5zDSH3b/jfgIz7osp74CFC5iWN+6Btj2bb96XMu/k5qyJU
         LXsaBUhZKhID2NlHEa53r73bNTJSMpYcOPON0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OhvQrTceF1APpGkBOFBqn2XcHhy3QOiCc2TIXWUYOrpDNMqR3PN+iLalspiSz167TG
         4G7VGn2UaqhNsiA9Q9FHkgZ4bqT+goe/4r08InbqwZZZY2LZ79AR299qWPIhyBpiSDfh
         x9WO9G3CtTjGJcGnH1PNumzdgrN0mE6Ct+tzI=
Received: by 10.141.40.7 with SMTP id s7mr575098rvj.192.1231894689610;
        Tue, 13 Jan 2009 16:58:09 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Tue, 13 Jan 2009 16:58:09 -0800 (PST)
In-Reply-To: <loom.20090113T213400-985@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105569>

On Tue, Jan 13, 2009 at 4:34 PM, Vladimir Pouzanov <farcaller@gmail.com> wrote:
> Jay Soffian <jaysoffian <at> gmail.com> writes:
>> Perhaps this will help in tracking down the problem.
>
> $ git svn clone http://qsb-mac.googlecode.com/svn/trunk qsb-mac
> Initialized empty Git repository in /Users/farcaller/temp/qsb-mac/.git/
> r1 = 810fe584c48b884460b5403a28bc61d872452b93 (git-svn)
> Temp file with moniker 'svn_delta' already in use at /opt/local/lib/perl5/
> site_perl/5.8.8/Git.pm line 1011.

One more thing to try. Edit your Git.pm and make the top of
_temp_cache() look like the following:

sub _temp_cache {
	my ($self, $name) = _maybe_self(@_);
	use Carp qw(longmess);
	warn longmess() if $name eq "svn_delta";

So you're adding the "use Carp..." and "warn..." lines.

Then try the import again. That should at least show why the svn_delta
temp file is being acquired twice.

(Yes, this is the printf school of debugging...)

j.
