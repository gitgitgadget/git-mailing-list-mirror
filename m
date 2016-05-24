From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Wed, 25 May 2016 06:03:29 +0700
Message-ID: <CACsJy8DkMDF85NMS8wS3CsNdt-vDpu6WajY1snxWV0GyeUJ7Vw@mail.gmail.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com> <1464130008.24478.134.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 25 01:04:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5LMr-0008UM-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 01:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbcEXXEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 19:04:00 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37668 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbcEXXD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 19:03:59 -0400
Received: by mail-ig0-f178.google.com with SMTP id l10so19513338igk.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s4CVw6vsP2W3fntpWYLAQaVqpY4cyG4tacllFQ8y+PI=;
        b=LX1EM6wVUL1sdPso3NDvsegbZ2yeUly5jyKi663StpwPLjzJrMMXd7uayZHuBBj8uT
         UGXuglQ24P4dkfC2wxsNPhvRrKgESWd3D6mMvNvNYbGYIS6+IjMjTlvkZ4K6rx+aYJnC
         7B+fdCtsiEhjLwwvzdK32bJA87Unnj3fqGwEnfcd4KT8A1/pYJiVnMf7bIBifwT76m++
         ivFX2kTjildHx1kQTyZZKGOPMwKyokIGL4LVAukqEXwqA6+FzuBo3mogI2WIm7PSCZS6
         tKhoqWUHvKe+tMycuhuJvgFyCorJX3F/gXJPcHc2BHbGull7pUN0rGQFoUCKp3DWmZVV
         hgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s4CVw6vsP2W3fntpWYLAQaVqpY4cyG4tacllFQ8y+PI=;
        b=A1E4dSp1EZ7YuyLxUqRawzYMGpbabpwYuMU88EFDVYIYezUADHc7jqP10jNTXJ7nOf
         ylgcDiYmIqEQ8h200mKlWIiKSHZxxwSdUuA5A8SgwPu4igWtXv0S8JlR8g/WrpgezZA4
         T+OOyPUdT0P91xJvwjMDBRGQB6F/YYfNTVYhtiniHbl/GShOTY8ecOD3m7G9lpPy33vO
         tDSaTV0IKJbKOLrx4PfpOR2e12B13ZbRitnpN0m7AjNsHCnrGnOKGOGaUoA12NNrLQQ3
         UfZoSPnDLWZKql6QqDGZkh/aCgHGbbsFiLhAPtWw5kpF7/8H+s2h2zyaEVi84zz1F/v9
         QO4Q==
X-Gm-Message-State: ALyK8tK8dR/DTz4+e9Z5uq6C9n5yrGpyHtH12+P1V+7nHE6q0Rwywl3OuTmtNQ8I82LPwQXW+6XlSqR+X+BESQ==
X-Received: by 10.50.50.135 with SMTP id c7mr1077494igo.33.1464131038699; Tue,
 24 May 2016 16:03:58 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 24 May 2016 16:03:29 -0700 (PDT)
In-Reply-To: <1464130008.24478.134.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295543>

On Wed, May 25, 2016 at 5:46 AM, David Turner <dturner@twopensource.com> wrote:
> I was looking at this again today, and noticed that it doesn't really
> address the HTTP case.
>
> The central problem is that protocol v2 goes like this:
> server: I have capabilities w,x,y, and z
> client: I want capabilities x and z.
>
> But HTTP goes like this:
> client: [request]
> server: [response]
>
> I tried to make libcurl do the receive-before-sending thing, but it
> doesn't seem to be designed for it (even if you prime things by sending
> a "hello" from the client first).  My thought was to hook up
> CURLOPT_READFUNCTION and CURLOPT_WRITEFUNCTION, and have the read
> function return CURL_READFUNC_PAUSE and then have the write (=client
> receiving data ) function unpause the reader (= client sending data)
> once it gets the capabilities.  But apparently pausing only works with
> chunked encoding, which seems to cause Apache's mod_cgi to fail.
>
> Maybe I'm missing something.  Has anyone else ever made something like
> this work?

It simply takes one more round-trip to negotiate. Not the best thing, but...

> I also looked to see if libcurl had websockets support, since that's
> one kind of bidirectional conversation over HTTP, but it doesn't seem
> to.

Yeah. And libcurl probably will not support websockets even in long
run. I've been searching for a websocket implementation for git and
finally settled for netcat-like programs, sitting in front of git and
dealing with network just like ssh. It will be the simplest way to add
either websocket or http/2 support. If either protocol gets popular
enough, smart-http can become a fall-back mechanism where performance
does not matter much.
-- 
Duy
