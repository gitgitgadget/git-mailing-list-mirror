Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F0EC2D0BF
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD10C24653
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ19Mess"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfLEKuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:50:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39242 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLEKuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 05:50:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so1435865pfx.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YBVx6CsvAcL9lkMGRglecln+NDJ+LOOXCtS97Ew+WCo=;
        b=UQ19MessEFS97ZMdn8eV4bAQ6+a31DayBA5knucZFB01THX5yQ6QJCe5fj1KSBFsLG
         gHPLqytrYTCp0lOxQu3UoEaEuCeBelwhUEvARp0b3oAV9rECGZ8rTRQc09uxOonul5tI
         SkfOre4L/IPl/Oo128PxTI4xcnObLsoGd7vaStPckLNm/GVnKnutDJsyyW6xmyyUm2VQ
         dx15qtPU6XyGAbqAgBkeAe+EhEzADw8pRmst4HwEG2CooZOowDdJWY0Fxbnoo30xQ31+
         8Si0WSL7P3uFLNDXjk6qyNUE3hta7D7Tfu2zjJtG7UbBELofItQMGPLQHfvjftm2WipL
         pLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YBVx6CsvAcL9lkMGRglecln+NDJ+LOOXCtS97Ew+WCo=;
        b=CmYLtRP7o/PS4laxamrBAReaDSThhHCnuIsCQMeI83BEEKJH7YjXGquOFDXqsJ+Mii
         1biCJZQ5qs/tZ1+uooAWNhZ7Mk68wZBHWXp1uuswKuHt9sw0u6TDksN8V8W6JfzjQYsB
         Aj2iyzPc+kxBwxOv+vENLyGxowJ47FoqRSgwYTSsAd044xIaH5kisBfpOPO5/gdOm7mp
         MiuHry7AWnSEzHz7EzClk/m6X5uRdak85yqPdD24kJOeQbfufeyKDbblYiXMRjzcLTAj
         aYEQlLd5tplP3zbJ1Zhd4Kvu995+XKP77HEnJ3/Wvjcid2sJEV7z7WvyZK7ln7HvfdlY
         Mn+w==
X-Gm-Message-State: APjAAAXuBSThPuoYciUN7uZc2ObWMHz8HJNE0IfUY5lnrAnnx06q61/V
        3DfcFVUwE8QGz7/0V6O3/i8=
X-Google-Smtp-Source: APXvYqxnrqpmkVrCHpSE+krEPAIF4UwMIkCX3dzi/J5Xn2V3QVcvEgh6aWhhAk1tsJL/MJAIK46ncQ==
X-Received: by 2002:a63:2e07:: with SMTP id u7mr8576568pgu.295.1575543039323;
        Thu, 05 Dec 2019 02:50:39 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id u18sm11147157pgi.44.2019.12.05.02.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 02:50:38 -0800 (PST)
Date:   Thu, 5 Dec 2019 02:50:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/11] git-p4: Add new functions in preparation of
 usage
Message-ID: <20191205105034.GB1192079@generichostname>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <1bf7b073b047ca7625d0861b160a9602135f7baf.1575498578.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf7b073b047ca7625d0861b160a9602135f7baf.1575498578.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: git-p4: Add new functions in preparation of usage

Nit: as a convention, you should lowercase the letter after the colon in
the subject. As in "git-p4: add new functions..."

This applies for other patches as well.

On Wed, Dec 04, 2019 at 10:29:31PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> This changelist is an intermediate submission for migrating the P4 support from Python2 to Python3. The code needs access to the encodeWithUTF8() for support of non-UTF8 filenames in the clone class as well as the sync class.
> 
> Move the function encodeWithUTF8() from the P4Sync class to a stand-alone function.  This will allow other classes to use this function without instanciating the P4Sync class. Change the self.verbose reference to an optional method parameter. Update the existing references to this function to pass the self.verbose since it is no longer available on "self" since the function is no longer contained on the P4Sync class.

Hmmm, so does the patch before this not actually work since
encodeWithUTF8() isn't defined yet? When you reroll this series, you
should swap the order of the patches since the previous patch depends on
this one, not the other way around.

> 
> Modify the functions write_pipe() and p4_write_pipe() to remove the return value.  The return value for both functions is the number of bytes, but the meaning is lost under python3 since the count does not match the number of characters that may have been encoded.  Additionally, the return value was never used, so this is removed to avoid future ambiguity.
> 
> Add a new method gitConfigSet(). This method will set a value in the git configuration cache list.
> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit affe888f432bb6833df78962e8671fccdf76c47a)
> ---
>  git-p4.py | 60 ++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index b283ef1029..2659531c2e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -237,6 +237,8 @@ def die(msg):
>          sys.exit(1)
>  
>  def write_pipe(c, stdin):
> +    """ Executes the command 'c', passing 'stdin' on the standard input
> +    """
>      if verbose:
>          sys.stderr.write('Writing pipe: %s\n' % str(c))
>  
> @@ -248,11 +250,12 @@ def write_pipe(c, stdin):
>      if p.wait():
>          die('Command failed: %s' % str(c))
>  
> -    return val
>  
>  def p4_write_pipe(c, stdin):
> +    """ Runs a P4 command 'c', passing 'stdin' data to P4
> +    """
>      real_cmd = p4_build_cmd(c)
> -    return write_pipe(real_cmd, stdin)
> +    write_pipe(real_cmd, stdin)
>  
>  def read_pipe_full(c):
>      """ Read output from  command. Returns a tuple
> @@ -653,6 +656,38 @@ def isModeExec(mode):
>      # otherwise False.
>      return mode[-3:] == "755"
>  
> +def encodeWithUTF8(path, verbose = False):

Nit: no spaces surrounding `=` in default args.

> +    """ Ensure that the path is encoded as a UTF-8 string
> +
> +        Returns bytes(P3)/str(P2)
> +    """
> +   

Trailing whitespace.

> +    if isunicode:
> +        try:
> +            if isinstance(path, unicode):
> +                # It is already unicode, cast it as a bytes
> +                # that is encoded as utf-8.
> +                return path.encode('utf-8', 'strict')
> +            path.decode('ascii', 'strict')
> +        except:
> +            encoding = 'utf8'
> +            if gitConfig('git-p4.pathEncoding'):
> +                encoding = gitConfig('git-p4.pathEncoding')
> +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
> +            if verbose:
> +                print('\nNOTE:Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, to_unicode(path)))
> +    else:    

Trailing whitespace.

> +        try:
> +            path.decode('ascii')
> +        except:
> +            encoding = 'utf8'
> +            if gitConfig('git-p4.pathEncoding'):
> +                encoding = gitConfig('git-p4.pathEncoding')
> +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
> +            if verbose:
> +                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
> +    return path
> +
>  class P4Exception(Exception):
>      """ Base class for exceptions from the p4 client """
>      def __init__(self, exit_code):
> @@ -891,6 +926,11 @@ def gitConfigList(key):
>              _gitConfig[key] = []
>      return _gitConfig[key]
>  
> +def gitConfigSet(key, value):
> +    """ Set the git configuration key 'key' to 'value' for this session
> +    """
> +    _gitConfig[key] = value
> +
>  def p4BranchesInGit(branchesAreInRemotes=True):
>      """Find all the branches whose names start with "p4/", looking
>         in remotes or heads as specified by the argument.  Return
> @@ -2814,24 +2854,12 @@ def writeToGitStream(self, gitMode, relPath, contents):
>              self.gitStream.write(d)
>          self.gitStream.write('\n')
>  
> -    def encodeWithUTF8(self, path):
> -        try:
> -            path.decode('ascii')
> -        except:
> -            encoding = 'utf8'
> -            if gitConfig('git-p4.pathEncoding'):
> -                encoding = gitConfig('git-p4.pathEncoding')
> -            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
> -            if self.verbose:
> -                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
> -        return path
> -
>      # output one file from the P4 stream
>      # - helper for streamP4Files
>  
>      def streamOneP4File(self, file, contents):
>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
> -        relPath = self.encodeWithUTF8(relPath)
> +        relPath = encodeWithUTF8(relPath, self.verbose)
>          if verbose:
>              if 'fileSize' in self.stream_file:
>                  size = int(self.stream_file['fileSize'])
> @@ -2914,7 +2942,7 @@ def streamOneP4File(self, file, contents):
>  
>      def streamOneP4Deletion(self, file):
>          relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
> -        relPath = self.encodeWithUTF8(relPath)
> +        relPath = encodeWithUTF8(relPath, self.verbose)
>          if verbose:
>              sys.stdout.write("delete %s\n" % relPath)
>              sys.stdout.flush()
> -- 
> gitgitgadget
> 
