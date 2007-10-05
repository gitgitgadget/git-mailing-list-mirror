From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 23:27:55 +0400
Message-ID: <37fcd2780710051227n96d29a9v543831ca8292c862@mail.gmail.com>
References: <20071005082026.GE19879@artemis.corp>
	 <20071005085522.32EFF1E16E@madism.org>
	 <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
	 <20071005162139.GC31413@uranus.ravnborg.org>
	 <alpine.LFD.0.999.0710050933330.23684@woody.linux-foundation.org>
	 <20071005172425.GD31413@uranus.ravnborg.org>
	 <alpine.LFD.0.999.0710051036282.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Bernt Hansen" <bernt@alumni.uwaterloo.ca>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 21:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdsqE-0000As-IG
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 21:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760529AbXJET16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 15:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759861AbXJET15
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 15:27:57 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:39009 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759471AbXJET15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 15:27:57 -0400
Received: by el-out-1112.google.com with SMTP id v27so204940ele
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5UCNHzVjRQuG3oIiVH1gsNSK52l3qvb0S0aPRlo2ZuM=;
        b=dB95Nf7W9F8XYvkY68hZMESas0nLrcUUxgDNdWDMah3fH0wg6B/FsK/4+PE58e8+QwsvgUxtUt7ibEEXxbNnNGN9Rl20thueahi8t3xLUF1IIxT8lrxPcX0xmzpEYksdxYdTjP63Pp0krFpCgicloYsprQlMIfAdqPmjXGfu6TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PTakIUtNRakRl9B6nNmA51ejhkQyxe10a9LVrNMcnPcKjt598rvLuJFtxXKASIlDNfRa8E6oQVQBoHNPjgk3SydvrCAze1gLzlNKMWeUpH77IdVVCGazdqZW5XhAiS6G1eu8SCnQKwRpCpD8SOFhB8Sh/K4w4+rtQLWOpE7HEog=
Received: by 10.143.9.5 with SMTP id m5mr2815456wfi.1191612475542;
        Fri, 05 Oct 2007 12:27:55 -0700 (PDT)
Received: by 10.143.37.15 with HTTP; Fri, 5 Oct 2007 12:27:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710051036282.23684@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60123>

On 10/5/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  - Qt (QString): QString::"data()", "ascii()" or "utf8()" or something.
>
>    At least this has the excuse of really being able to handle different
>    locales (it didn't do that originally, though!), but they end up having
>    a million helper functions exactly because you cannot use the normal
>    string routines on anything!

I am afraid you cannot allow the direct access to the internal buffer of
a string if this buffer can be implicitly shared between different
instances as it is the case with QString. Because when you want to make
some modification or want to get a non-const pointer to this buffer, its
content has to be copied if the buffer is shared between a few copies.

On the other hand, I don't see what is the problem with using C string
routines with it. ::data() returns a pointer and :capacity () returns
allocated size of the buffer. ::resize() changes the size of the string.
If you need a greater allocated size, you can use ::reserve().
Or did I miss something?

Dmitry
